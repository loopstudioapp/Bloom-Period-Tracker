import SwiftUI

struct PartnerPhoneMockup: View {
    var body: some View {
        VStack(spacing: 0) {
            // Phone frame
            VStack(spacing: AppTheme.Spacing.sm) {
                // Top bar with bear avatar
                HStack {
                    BearAvatarView(size: 24, backgroundColor: AppTheme.Colors.bearAvatarBlue)
                    Spacer()
                }
                .padding(.horizontal, AppTheme.Spacing.sm)

                // Title
                Text("Discover top insights about her \u{00B7} Today")
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppTheme.Spacing.sm)

                // Three colored cards
                HStack(spacing: AppTheme.Spacing.sm) {
                    // Yellow card - Cycle day
                    VStack(spacing: AppTheme.Spacing.xxs) {
                        Text("Your partner's\ncycle day")
                            .font(.system(size: 8, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                        Text("1")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(AppTheme.Colors.partnerYellowCard)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))

                    // Pink card - Symptoms
                    VStack(spacing: AppTheme.Spacing.xxs) {
                        Text("Their possible\nsymptoms")
                            .font(.system(size: 8, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                        HStack(spacing: 2) {
                            Text("\u{2764}\u{FE0F}")
                                .font(.system(size: 14))
                            Text("\u{1F970}")
                                .font(.system(size: 14))
                            Text("\u{1F922}")
                                .font(.system(size: 14))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(AppTheme.Colors.partnerPinkCard)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))

                    // Teal card - Pregnancy chance
                    VStack(spacing: AppTheme.Spacing.xxs) {
                        Text("Chance of\ngetting pregnant")
                            .font(.system(size: 8, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                        Text("Low")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(AppTheme.Colors.partnerTealCard)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))
                }
                .padding(.horizontal, AppTheme.Spacing.sm)

                // Period bar
                HStack {
                    Text("Period")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.textWhite)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTheme.Spacing.xs)
                .background(AppTheme.Colors.primaryPink)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))
                .padding(.horizontal, AppTheme.Spacing.sm)
            }
            .padding(.vertical, AppTheme.Spacing.md)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.partnerPhoneMockBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))
        .accessibilityLabel("Partner app phone mockup showing cycle insights")
    }
}

#Preview {
    PartnerPhoneMockup()
        .frame(width: 280)
        .padding()
}
