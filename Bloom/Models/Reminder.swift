import SwiftUI

struct ReminderItem: Identifiable {
    let id = UUID()
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
        ReminderItem(title: "Secret Chats push notifications", isEnabled: true, time: nil, section: .secretChats),
        ReminderItem(title: "Period in a couple of days", isEnabled: true, time: "10:00 AM", section: .cycle),
        ReminderItem(title: "Period end", isEnabled: false, time: nil, section: .cycle),
        ReminderItem(title: "Period start", isEnabled: true, time: "10:00 AM", section: .cycle),
        ReminderItem(title: "Ovulation", isEnabled: false, time: nil, section: .cycle),
        ReminderItem(title: "Contraception", isEnabled: false, time: nil, section: .medication),
        ReminderItem(title: "Log weight", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(title: "Log sleep", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(title: "Log temperature", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(title: "Drink water", isEnabled: false, time: nil, section: .lifestyle),
        ReminderItem(title: "Step goal achieved", isEnabled: true, time: nil, section: .lifestyle)
    ]
}
