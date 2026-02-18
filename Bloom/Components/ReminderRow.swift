import SwiftUI

struct ReminderRow: View {
    let title: String
    let isEnabled: Bool
    var time: String? = nil
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                HStack {
                    // Title
                    Text(title)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    // Status text
                    HStack(spacing: AppTheme.Spacing.xs) {
                        Text(statusText)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                }
                .padding(.vertical, AppTheme.Spacing.md)

                // Thin divider at bottom
                Rectangle()
                    .fill(AppTheme.Colors.divider)
                    .frame(height: 0.5)
            }
        }
        .buttonStyle(.plain)
    }

    private var statusText: String {
        if isEnabled {
            if let time = time {
                return "On \u{00B7} \(time)"
            }
            return "On"
        }
        return "Off"
    }
}

#Preview {
    VStack(spacing: 0) {
        ReminderRow(
            title: "Period Reminder",
            isEnabled: true,
            time: "9:00 AM"
        )

        ReminderRow(
            title: "Pill Reminder",
            isEnabled: false
        )

        ReminderRow(
            title: "Water Reminder",
            isEnabled: true,
            time: "Every 2 hours"
        )
    }
    .padding(.horizontal, AppTheme.Spacing.md)
}
