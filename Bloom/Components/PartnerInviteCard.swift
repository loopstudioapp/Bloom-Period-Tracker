import SwiftUI

struct PartnerInviteCard: View {
    let onInvite: () -> Void
    let onDecline: () -> Void

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xl) {
            // Title
            VStack(spacing: AppTheme.Spacing.xs) {
                Text("Supercharge your sex lives with")
                    .font(AppTheme.Fonts.title2)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Bloom for Partners")
                    .font(AppTheme.Fonts.title2)
                    .foregroundColor(AppTheme.Colors.primaryPink)
                    .multilineTextAlignment(.center)
            }

            // Feature bullets
            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                ForEach(bulletTexts, id: \.self) { text in
                    featureBullet(text: text)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            // Invite button
            PillButton(
                title: "Invite my partner",
                style: .primary,
                action: onInvite
            )

            // Decline button
            Button(action: onDecline) {
                Text("I'm not interested")
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
            .padding(.top, -declineTopAdjustment)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
    }

    // MARK: - Private Views

    private func featureBullet(text: String) -> some View {
        HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
            // Pink circled checkmark
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: checkmarkSize))
                .foregroundColor(AppTheme.Colors.checkmark)
                .frame(width: checkmarkSize, height: checkmarkSize)

            Text(text)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Private Helpers

    private var bulletTexts: [String] {
        [
            "Share your cycle phase predictions so they're empowered to support you.",
            "Tune them into your sex drive.",
            "Boost your connection and communication."
        ]
    }

    private var checkmarkSize: CGFloat { AppTheme.Spacing.xl }
    private var declineTopAdjustment: CGFloat { AppTheme.Spacing.sm + AppTheme.Spacing.xs }
}

#Preview {
    PartnerInviteCard(
        onInvite: {},
        onDecline: {}
    )
}
