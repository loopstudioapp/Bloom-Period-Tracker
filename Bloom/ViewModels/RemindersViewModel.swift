import SwiftUI
import UserNotifications

@MainActor
class RemindersViewModel: ObservableObject {
    @Published var reminders: [ReminderItem] = []
    @Published var notificationsDenied: Bool = false

    private let defaults = UserDefaults.standard
    private let enabledKeyPrefix = "reminder_enabled_"

    init() {
        loadReminders()
    }

    // MARK: - Load / Save

    private func loadReminders() {
        reminders = ReminderData.allReminders.map { reminder in
            var item = reminder
            let key = enabledKeyPrefix + reminder.id
            if defaults.object(forKey: key) != nil {
                item.isEnabled = defaults.bool(forKey: key)
            }
            return item
        }
    }

    private func saveReminderState(_ reminder: ReminderItem) {
        let key = enabledKeyPrefix + reminder.id
        defaults.set(reminder.isEnabled, forKey: key)
    }

    // MARK: - Toggle

    func toggleReminder(at index: Int) {
        guard index < reminders.count else { return }
        reminders[index].isEnabled.toggle()
        saveReminderState(reminders[index])

        if reminders[index].isEnabled {
            requestPermissionAndSchedule(reminder: reminders[index])
        } else {
            removeNotification(for: reminders[index])
        }
    }

    func reminders(for section: ReminderSection) -> [ReminderItem] {
        reminders.filter { $0.section == section }
    }

    // MARK: - Notifications

    private func requestPermissionAndSchedule(reminder: ReminderItem) {
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    self?.scheduleNotification(for: reminder)
                case .notDetermined:
                    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                        DispatchQueue.main.async {
                            if granted {
                                self?.scheduleNotification(for: reminder)
                            } else {
                                self?.notificationsDenied = true
                            }
                        }
                    }
                case .denied:
                    self?.notificationsDenied = true
                @unknown default:
                    break
                }
            }
        }
    }

    private func scheduleNotification(for reminder: ReminderItem) {
        let center = UNUserNotificationCenter.current()
        let cycle = CycleService.shared

        let content = UNMutableNotificationContent()
        content.sound = .default

        switch reminder.id {
        case "period_couple_days":
            content.title = "Period Coming Soon"
            content.body = "Your period is expected in a couple of days. Be prepared!"
            if let start = cycle.currentCycleStartDate {
                let nextPeriod = cycle.nextCycleStart(from: start)
                let alertDate = Calendar.current.date(byAdding: .day, value: -2, to: nextPeriod)!
                let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: setTime(on: alertDate, hour: 10, minute: 0))
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                center.add(request)
            }

        case "period_start":
            content.title = "Period Expected Today"
            content.body = "Your period is predicted to start today. Take care!"
            if let start = cycle.currentCycleStartDate {
                let nextPeriod = cycle.nextCycleStart(from: start)
                let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: setTime(on: nextPeriod, hour: 10, minute: 0))
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                center.add(request)
            }

        case "period_end":
            content.title = "Period Ending Soon"
            content.body = "Your period should be ending around now."
            if let start = cycle.currentCycleStartDate {
                let endDate = cycle.predictedPeriodEnd(from: start)
                let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: setTime(on: endDate, hour: 10, minute: 0))
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                center.add(request)
            }

        case "ovulation":
            content.title = "Ovulation Day"
            content.body = "Today is your predicted ovulation day."
            if let start = cycle.currentCycleStartDate {
                let ovDate = cycle.predictedOvulation(from: start)
                let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: setTime(on: ovDate, hour: 10, minute: 0))
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                center.add(request)
            }

        case "drink_water":
            content.title = "Hydration Reminder"
            content.body = "Don't forget to drink water! Staying hydrated helps with your cycle."
            var comps = DateComponents()
            comps.hour = 12
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        case "log_weight":
            content.title = "Log Your Weight"
            content.body = "Track your weight to see patterns across your cycle."
            var comps = DateComponents()
            comps.hour = 8
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        case "log_sleep":
            content.title = "Log Your Sleep"
            content.body = "How did you sleep? Track it to discover cycle-related patterns."
            var comps = DateComponents()
            comps.hour = 9
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        case "log_temperature":
            content.title = "Log Your Temperature"
            content.body = "Take your basal body temperature before getting up."
            var comps = DateComponents()
            comps.hour = 7
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        case "step_goal":
            content.title = "Step Goal Check"
            content.body = "Have you hit your step goal today? Get moving!"
            var comps = DateComponents()
            comps.hour = 18
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        case "contraception":
            content.title = "Contraception Reminder"
            content.body = "Don't forget your contraception today."
            var comps = DateComponents()
            comps.hour = 9
            comps.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            center.add(request)

        default:
            break
        }
    }

    private func removeNotification(for reminder: ReminderItem) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id])
    }

    private func setTime(on date: Date, hour: Int, minute: Int) -> Date {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        comps.hour = hour
        comps.minute = minute
        return Calendar.current.date(from: comps) ?? date
    }
}
