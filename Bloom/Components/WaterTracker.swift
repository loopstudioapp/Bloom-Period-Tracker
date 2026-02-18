import SwiftUI

struct WaterTracker: View {
    @Binding var intake: Int
    let goal: Int

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.system(size: 20))
                    .foregroundColor(AppTheme.Colors.waterIconColor)

                Text("Water")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Button(action: { intake = max(0, intake - 8) }) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(width: 32, height: 32)
                        .background(AppTheme.Colors.trackerButtonBg)
                        .clipShape(Circle())
                }

                Button(action: { intake += 8 }) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(width: 32, height: 32)
                        .background(AppTheme.Colors.trackerButtonBg)
                        .clipShape(Circle())
                }
            }

            HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                Text("\(intake)")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Text("/ \(goal) fl. oz.")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            Button(action: {}) {
                HStack {
                    Text("Reminders and Settings")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.sectionCardBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }
}
