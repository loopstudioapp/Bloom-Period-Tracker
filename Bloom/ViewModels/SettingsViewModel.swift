import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var selectedGoal: String = "Track cycle"
    @Published var showReminders: Bool = false
    @Published var showAppSettings: Bool = false
    @Published var showAnalysisMenu: Bool = false
    @Published var showReportPreview: Bool = false
    @Published var emailConfirmed: Bool = false
    @AppStorage("isPremiumUser") var isPremium: Bool = false

    let goals = ["Track cycle", "Get pregnant", "Track pregnancy"]

    let friendAvatars: [(String, Color)] = [
        ("🐻", AppTheme.Colors.avatarPurple),
        ("🐻", AppTheme.Colors.orangeAccent),
        ("🐻", AppTheme.Colors.avatarPink),
        ("🐻", AppTheme.Colors.bearAvatarBlue),
        ("🐻", AppTheme.Colors.avatarPurple)
    ]
}
