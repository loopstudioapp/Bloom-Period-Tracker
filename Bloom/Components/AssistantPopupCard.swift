import SwiftUI

struct AssistantPopupCard: View {
    let title: String
    let message: String
    let ctaText: String
    var onCTA: () -> Void = {}
    var onDismiss: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            // Header: title + close button
            headerRow

            // Message row: avatar + bubble
            messageRow

            // CTA button
            ctaButton
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.assistantPopupBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))
        .elevatedShadow()
    }

    // MARK: - Header

    private var headerRow: some View {
        HStack {
            Text(title)
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            Button(action: onDismiss) {
                ZStack {
                    Circle()
                        .fill(AppTheme.Colors.dayDetailSummaryBg)
                        .frame(width: closeButtonSize, height: closeButtonSize)

                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Message Row

    private var messageRow: some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
            // Pink avatar circle with leaf icon
            ZStack {
                Circle()
                    .fill(AppTheme.Colors.assistantAvatarBg)
                    .frame(width: avatarSize, height: avatarSize)

                Image(systemName: "leaf.fill")
                    .font(.system(size: 18))
                    .foregroundColor(AppTheme.Colors.textWhite)
            }

            // Chat bubble
            Text(message)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.assistantBubbleText)
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.assistantBubbleBg)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
        }
    }

    // MARK: - CTA Button

    private var ctaButton: some View {
        Button(action: onCTA) {
            Text(ctaText)
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textWhite)
                .frame(maxWidth: .infinity)
                .frame(height: AppTheme.ButtonHeight.secondary)
                .background(AppTheme.Colors.primaryPink)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Sizes

    private var avatarSize: CGFloat { 40 }
    private var closeButtonSize: CGFloat { AppTheme.Spacing.xxl }
}

#Preview {
    AssistantPopupCard(
        title: "Health Assistant",
        message: "Based on your cycle data, you may experience increased fatigue this week. Here are some tips to help manage your energy levels.",
        ctaText: "View Recommendations"
    )
    .padding(AppTheme.Spacing.md)
    .background(AppTheme.Colors.backgroundLight)
}
