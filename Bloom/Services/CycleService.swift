import SwiftUI

class CycleService {
    static let shared = CycleService()

    let averageCycleLength: Int = 29
    let averagePeriodLength: Int = 5
    let ovulationDay: Int = 14

    func predictedPeriodEnd(from start: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: averagePeriodLength, to: start)!
    }

    func predictedOvulation(from periodStart: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: ovulationDay, to: periodStart)!
    }

    func fertileWindow(from periodStart: Date) -> (start: Date, end: Date) {
        let ovulation = predictedOvulation(from: periodStart)
        let start = Calendar.current.date(byAdding: .day, value: -3, to: ovulation)!
        let end = Calendar.current.date(byAdding: .day, value: 2, to: ovulation)!
        return (start, end)
    }

    func nextCycleStart(from periodStart: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: averageCycleLength, to: periodStart)!
    }

    func cyclePhase(for date: Date, periodStart: Date) -> CyclePhaseType {
        let daysSince = Calendar.current.dateComponents([.day], from: periodStart, to: date).day ?? 0
        if daysSince < averagePeriodLength { return .period }
        if daysSince < ovulationDay - 3 { return .follicular }
        if daysSince < ovulationDay + 2 { return .fertile }
        if daysSince == ovulationDay { return .ovulation }
        return .luteal
    }
}
