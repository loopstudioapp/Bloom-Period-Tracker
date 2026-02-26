import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var selectedGoal: String = "Track cycle"
    @Published var showReminders: Bool = false
    @Published var showAppSettings: Bool = false
    @Published var showAnalysisMenu: Bool = false
    @Published var showReportPreview: Bool = false
    @AppStorage("isPremiumUser") var isPremium: Bool = false

    let goals = ["Track cycle", "Get pregnant", "Track pregnancy"]
}
