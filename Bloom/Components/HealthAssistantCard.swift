import SwiftUI

struct HealthAssistantCard: View {
    let rows: [HealthAssistantChatRow]

    var body: some View {
        VStack(spacing: .zero) {
            // Header
            headerRow

            Divider()
                .background(AppTheme.Colors.divider)
                .padding(.horizontal, AppTheme.Spacing.md)

            // Chat rows
            ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                chatRow(row)

                if index < rows.count - 1 {
                    Divider()
                        .background(AppTheme.Colors.divider)
                        .padding(.horizontal, AppTheme.Spacing.md)
                }
            }
        }
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }

    // MARK: - Header

    private var headerRow: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            // Robot emoji in teal circle
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.tealAccent)
                    .frame(width: headerIconSize, height: headerIconSize)

                Text("\u{1F916}")
                    .font(.system(size: headerEmojiSize))
            }

            Text("Health Assistant")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            // Info icon
            Image(systemName: "info.circle")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(AppTheme.Spacing.md)
    }

    // MARK: - Chat Row

    private func chatRow(_ row: HealthAssistantChatRow) -> some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
            // Pink dot indicator
            if row.showDotIndicator {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: dotSize, height: dotSize)
                    .padding(.top, AppTheme.Spacing.sm)
            } else {
                Color.clear
                    .frame(width: dotSize, height: dotSize)
            }

            // Icon circle
            ZStack {
                Circle()
                    .fill(row.iconBackgroundColor)
                    .frame(width: rowIconSize, height: rowIconSize)

                Image(systemName: row.iconName)
                    .font(.system(size: rowIconFontSize))
                    .foregroundColor(AppTheme.Colors.textWhite)
            }

            // Text content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                HStack {
                    Text(row.title)
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    Text(row.time)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                Text(row.descriptionText)
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding(AppTheme.Spacing.md)
    }

    // MARK: - Sizes

    private var headerIconSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var headerEmojiSize: CGFloat { AppTheme.Spacing.lg }
    private var rowIconSize: CGFloat { AppTheme.Spacing.xxl + AppTheme.Spacing.sm }
    private var rowIconFontSize: CGFloat { AppTheme.Spacing.md }
    private var dotSize: CGFloat { AppTheme.Spacing.sm }
}

#Preview {
    HealthAssistantCard(rows: OnboardingData.healthAssistantRows)
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.backgroundLight)
}
