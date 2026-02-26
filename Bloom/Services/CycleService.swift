import SwiftUI

class CycleService: ObservableObject {
    static let shared = CycleService()

    // MARK: - Stored Data (same keys onboarding writes to)

    @AppStorage("recentPeriodStartDate") private var recentStartStr = ""
    @AppStorage("recentPeriodEndDate") private var recentEndStr = ""
    @AppStorage("previousPeriodStartDate") private var previousStartStr = ""
    @AppStorage("previousPeriodEndDate") private var previousEndStr = ""

    private let cal = Calendar.current

    private static let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f
    }()

    // MARK: - Parsed Dates

    var recentPeriodStart: Date? {
        Self.isoFormatter.date(from: recentStartStr)
    }

    var recentPeriodEnd: Date? {
        Self.isoFormatter.date(from: recentEndStr)
    }

    var previousPeriodStart: Date? {
        Self.isoFormatter.date(from: previousStartStr)
    }

    var previousPeriodEnd: Date? {
        Self.isoFormatter.date(from: previousEndStr)
    }

    var hasData: Bool {
        recentPeriodStart != nil
    }

    // MARK: - Computed Cycle Metrics

    /// Cycle length calculated from two logged periods, or default 28
    var cycleLength: Int {
        guard let recent = recentPeriodStart, let previous = previousPeriodStart else { return 28 }
        let days = cal.dateComponents([.day], from: previous, to: recent).day ?? 28
        return max(days, 21) // sanity floor
    }

    /// Period length from most recent start→end, or default 5
    var periodLength: Int {
        guard let start = recentPeriodStart, let end = recentPeriodEnd else { return 5 }
        let days = cal.dateComponents([.day], from: start, to: end).day ?? 4
        return max(days + 1, 1) // inclusive of both start and end day
    }

    /// Ovulation typically occurs ~14 days before the NEXT period (luteal phase is ~14 days)
    var ovulationDay: Int {
        max(cycleLength - 14, 10) // floor at day 10
    }

    // MARK: - Current Cycle State

    /// The start date of the cycle the user is currently in.
    /// If enough time has passed since the recent period, project forward by cycle length.
    var currentCycleStartDate: Date? {
        guard let recentStart = recentPeriodStart else { return nil }
        let today = cal.startOfDay(for: Date())
        let recentStartDay = cal.startOfDay(for: recentStart)

        let daysSinceRecent = cal.dateComponents([.day], from: recentStartDay, to: today).day ?? 0

        if daysSinceRecent < 0 {
            // Recent period is in the future (shouldn't happen, but handle gracefully)
            return recentStartDay
        }

        if daysSinceRecent < cycleLength {
            // Still within the cycle that started at recentPeriodStart
            return recentStartDay
        }

        // Project forward: how many full cycles have passed?
        let cyclesPassed = daysSinceRecent / cycleLength
        return cal.date(byAdding: .day, value: cyclesPassed * cycleLength, to: recentStartDay)
    }

    /// Current day within the cycle (1-indexed)
    var currentCycleDay: Int {
        guard let start = currentCycleStartDate else { return 1 }
        let today = cal.startOfDay(for: Date())
        let days = cal.dateComponents([.day], from: start, to: today).day ?? 0
        return days + 1
    }

    /// Whether the user is currently on their period
    var isOnPeriod: Bool {
        currentCycleDay <= periodLength
    }

    /// Current period day (0 if not on period)
    var periodDay: Int {
        isOnPeriod ? currentCycleDay : 0
    }

    /// Days until the fertile window begins (ovulation day - 3)
    var fertileDaysAway: Int {
        let fertileStart = ovulationDay - 3
        let daysAway = fertileStart - currentCycleDay
        return max(daysAway, 0)
    }

    var currentPhase: CyclePhaseType {
        guard let start = currentCycleStartDate else { return .follicular }
        return cyclePhase(for: Date(), periodStart: start)
    }

    // MARK: - Cycle Entries for History Display

    var currentCycle: CycleEntry? {
        guard let start = currentCycleStartDate else { return nil }
        return CycleEntry(
            startDate: start,
            endDate: nil,
            periodLength: periodLength,
            cycleLength: nil,
            isCurrentCycle: true
        )
    }

    var previousCycles: [CycleEntry] {
        guard let recentStart = recentPeriodStart else { return [] }

        // If the current cycle start is projected forward (not the recent period),
        // then the recent period is a previous cycle
        var cycles: [CycleEntry] = []

        if let currentStart = currentCycleStartDate,
           !cal.isDate(currentStart, inSameDayAs: recentStart) {
            cycles.append(CycleEntry(
                startDate: recentStart,
                endDate: recentPeriodEnd ?? cal.date(byAdding: .day, value: periodLength - 1, to: recentStart),
                periodLength: periodLength,
                cycleLength: cycleLength,
                isCurrentCycle: false
            ))
        }

        if let prevStart = previousPeriodStart {
            let prevPeriodLen: Int
            if let prevEnd = previousPeriodEnd {
                prevPeriodLen = max((cal.dateComponents([.day], from: prevStart, to: prevEnd).day ?? 4) + 1, 1)
            } else {
                prevPeriodLen = 5
            }
            cycles.append(CycleEntry(
                startDate: prevStart,
                endDate: previousPeriodEnd ?? cal.date(byAdding: .day, value: prevPeriodLen - 1, to: prevStart),
                periodLength: prevPeriodLen,
                cycleLength: cycleLength,
                isCurrentCycle: false
            ))
        }

        return cycles
    }

    // MARK: - Cycle Summary Metrics

    var cycleSummaryMetrics: [CycleMetric] {
        guard hasData else { return [] }

        let cycleLenValue = "\(cycleLength) days"
        let cycleLenStatus: CycleMetricStatus = (cycleLength >= 21 && cycleLength <= 35) ? .normal : .abnormal
        let cycleLenLabel = cycleLenStatus == .normal ? "NORMAL" : "ABNORMAL"

        let periodLenValue = "\(periodLength) days"
        let periodLenStatus: CycleMetricStatus = (periodLength >= 2 && periodLength <= 7) ? .normal : .abnormal
        let periodLenLabel = periodLenStatus == .normal ? "NORMAL" : "ABNORMAL"

        return [
            CycleMetric(label: "Cycle length", value: cycleLenValue, status: cycleLenStatus, statusLabel: cycleLenLabel),
            CycleMetric(label: "Period length", value: periodLenValue, status: periodLenStatus, statusLabel: periodLenLabel)
        ]
    }

    // MARK: - Prediction Methods

    func predictedPeriodEnd(from start: Date) -> Date {
        cal.date(byAdding: .day, value: periodLength - 1, to: start)!
    }

    func predictedOvulation(from periodStart: Date) -> Date {
        cal.date(byAdding: .day, value: ovulationDay, to: periodStart)!
    }

    func fertileWindow(from periodStart: Date) -> (start: Date, end: Date) {
        let ovulation = predictedOvulation(from: periodStart)
        let start = cal.date(byAdding: .day, value: -3, to: ovulation)!
        let end = cal.date(byAdding: .day, value: 2, to: ovulation)!
        return (start, end)
    }

    func nextCycleStart(from periodStart: Date) -> Date {
        cal.date(byAdding: .day, value: cycleLength, to: periodStart)!
    }

    func cyclePhase(for date: Date, periodStart: Date) -> CyclePhaseType {
        let daysSince = cal.dateComponents([.day], from: periodStart, to: date).day ?? 0
        if daysSince < 0 { return .follicular }
        if daysSince < periodLength { return .period }
        if daysSince < ovulationDay - 3 { return .follicular }
        if daysSince == ovulationDay { return .ovulation }
        if daysSince >= ovulationDay - 3 && daysSince <= ovulationDay + 2 { return .fertile }
        return .luteal
    }
}
