import SwiftUI

struct ReminderItem: Identifiable {
    let id: String  // Stable ID for persistence
    let title: String
    var isEnabled: Bool
    var time: String?
    let section: ReminderSection
}

enum ReminderSection: String, CaseIterable {
    case secretChats = "SECRET CHATS"
    case cycle = "CYCLE"
    case medication = "MEDICATION AND CONTRACEPTION"
    case lifestyle = "LIFESTYLE"
}

struct ReminderData {
    static let allReminders: [ReminderItem] = [
        ReminderItem(id: "secret_chats_push", title: "Secret Chats push notifications", isEnabled: true, time: nil, section: .secretChats),
        ReminderItem(id: "period_couple_days", title: "Period in a couple of days", isEnabled: true, time: "10:00 AM", section: .cycle),
        ReminderItem(id: "period_end", title: "Period end", isEnabled: false, time: nil, section: .cycle),
        ReminderItem(id: "period_start", title: "Period start", isEnabled: true, time: "10:00 AM", section: .cycle),
        ReminderItem(id: "ovulation", title: "Ovulation", isEnabled: false, time: nil, section: .cycle),
        ReminderItem(id: "contraception", title: "Contraception", isEnabled: false, time: nil, section: .medication),
        ReminderItem(id: "log_weight", title: "Log weight", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(id: "log_sleep", title: "Log sleep", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(id: "log_temperature", title: "Log temperature", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(id: "drink_water", title: "Drink water", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(id: "step_goal", title: "Step goal achieved", isEnabled: true, time: nil, section: .lifestyle)
    ]
}
