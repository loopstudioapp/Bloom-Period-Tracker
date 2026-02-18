import SwiftUI

enum CyclePhaseType: String, CaseIterable {
    case period, follicular, fertile, ovulation, luteal
}

enum DayState: Equatable {
    case normal
    case period(dayNumber: Int)
    case fertile
    case ovulation
    case predictedPeriod
    case predictedOvulation
    case today
}

struct CycleEntry: Identifiable {
    let id = UUID()
    let startDate: Date
    let endDate: Date?
    let periodLength: Int
    let cycleLength: Int?
    let isCurrentCycle: Bool
}

struct DayLog: Identifiable {
    let id = UUID()
    let date: Date
    var symptoms: Set<String>
    var menstrualFlow: MenstrualFlow?
    var sexActivity: Set<String>
    var waterOz: Int
    var weightLbs: Double?
    var steps: Int?
    var basalTemp: Double?
    var mood: String?
}

enum MenstrualFlow: String, CaseIterable {
    case light = "Light"
    case medium = "Medium"
    case heavy = "Heavy"
    case bloodClots = "Blood clots"

    var icon: String {
        switch self {
        case .light: return "🩸"
        case .medium: return "🩸"
        case .heavy: return "🩸"
        case .bloodClots: return "💧"
        }
    }
}

struct WeekDay: Identifiable {
    let id = UUID()
    let date: Date
    let dayNumber: Int
    let dayLetter: String
    let isPeriod: Bool
    let isToday: Bool
    let isFertile: Bool
}

struct CycleMetric: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let status: CycleMetricStatus
    let statusLabel: String
}

enum CycleMetricStatus {
    case normal, abnormal, irregular

    var color: Color {
        switch self {
        case .normal: return AppTheme.Colors.normalBadgeBg
        case .abnormal, .irregular: return AppTheme.Colors.abnormalBadgeBg
        }
    }
}

struct SymptomPattern: Identifiable {
    let id = UUID()
    let symptomName: String
    let icon: String
    let iconColor: Color
    let description: String
    let percentage: Int
    let cycleData: [[CycleDotState]]
}

enum CycleDotState {
    case period, fertile, ovulation, normal, symptom, empty
}
