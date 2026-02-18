import SwiftUI

@MainActor
class RemindersViewModel: ObservableObject {
    @Published var reminders: [ReminderItem] = ReminderData.allReminders

    func toggleReminder(at index: Int) {
        guard index < reminders.count else { return }
        reminders[index].isEnabled.toggle()
    }

    func reminders(for section: ReminderSection) -> [ReminderItem] {
        reminders.filter { $0.section == section }
    }
}
