import SwiftUI

struct RemindersView: View {
    @StateObject private var viewModel = RemindersViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            ForEach(ReminderSection.allCases, id: \.self) { section in
                Section {
                    let sectionReminders = viewModel.reminders(for: section)

                    ForEach(Array(sectionReminders.enumerated()), id: \.element.id) { index, reminder in
                        if section == .secretChats && index == 0 {
                            // Secret chats toggle row
                            secretChatsToggleRow(reminder: reminder)
                        } else {
                            ReminderRow(
                                title: reminder.title,
                                isEnabled: reminder.isEnabled,
                                time: reminder.time,
                                onTap: {
                                    toggleReminder(reminder)
                                }
                            )
                            .listRowInsets(EdgeInsets(
                                top: 0,
                                leading: AppTheme.Spacing.md,
                                bottom: 0,
                                trailing: AppTheme.Spacing.md
                            ))
                        }
                    }

                    // Add pill reminder link for medication section
                    if section == .medication {
                        addPillReminderButton
                    }
                } header: {
                    sectionHeader(section.rawValue)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(AppTheme.Colors.backgroundLight)
        .navigationTitle("Reminders")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .accessibilityLabel("Back")
            }
        }
    }

    // MARK: - Section Header

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(AppTheme.Fonts.caption)
            .foregroundColor(AppTheme.Colors.sectionHeaderText)
            .textCase(.uppercase)
    }

    // MARK: - Secret Chats Toggle Row

    private func secretChatsToggleRow(reminder: ReminderItem) -> some View {
        HStack {
            Text(reminder.title)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Toggle("", isOn: toggleBinding(for: reminder))
                .labelsHidden()
                .tint(AppTheme.Colors.toggleOnTrack)
        }
        .padding(.vertical, AppTheme.Spacing.sm)
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: AppTheme.Spacing.md,
            bottom: 0,
            trailing: AppTheme.Spacing.md
        ))
    }

    // MARK: - Add Pill Reminder Button

    private var addPillReminderButton: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .medium))

                Text("Add a pill reminder")
                    .font(AppTheme.Fonts.subheadlineBold)
            }
            .foregroundColor(AppTheme.Colors.addPillReminderText)
        }
        .buttonStyle(.plain)
        .padding(.vertical, AppTheme.Spacing.sm)
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: AppTheme.Spacing.md,
            bottom: 0,
            trailing: AppTheme.Spacing.md
        ))
    }

    // MARK: - Helpers

    private func toggleReminder(_ reminder: ReminderItem) {
        if let index = viewModel.reminders.firstIndex(where: { $0.id == reminder.id }) {
            viewModel.toggleReminder(at: index)
        }
    }

    private func toggleBinding(for reminder: ReminderItem) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                viewModel.reminders.first(where: { $0.id == reminder.id })?.isEnabled ?? false
            },
            set: { _ in
                toggleReminder(reminder)
            }
        )
    }
}

#Preview {
    NavigationStack {
        RemindersView()
    }
}
