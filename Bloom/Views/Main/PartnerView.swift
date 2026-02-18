import SwiftUI

struct PartnerView: View {
    @StateObject private var viewModel = PartnerViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    gradientHeroCard
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.md)
                .padding(.bottom, AppTheme.Spacing.xxxl)
            }
            .background(AppTheme.Colors.background)
            .navigationTitle("Partner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Gradient Hero Card
    private var gradientHeroCard: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            // Gradient title
            Text("Bloom for Partners")
                .font(AppTheme.Fonts.title1)
                .foregroundStyle(
                    LinearGradient(
                        colors: [AppTheme.Colors.avatarPurple, AppTheme.Colors.primaryPink, AppTheme.Colors.orangeAccent],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            Text("Supercharge your sex lives")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Share your cycle insights with your partner!")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            // Benefits
            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                ForEach(viewModel.benefits, id: \.1) { icon, text in
                    HStack(spacing: AppTheme.Spacing.md) {
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(AppTheme.Colors.addLogFAB)

                        Text(text)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            // Phone mockup section
            Text("What your partner sees")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)

            PartnerPhoneMockup()
                .frame(maxWidth: 280)

            // CTA Button
            Button(action: { viewModel.linkPartner() }) {
                Text("Link your partner")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppTheme.ButtonHeight.primary)
                    .background(AppTheme.Colors.primaryPink)
                    .clipShape(Capsule())
            }
        }
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.partnerCardGradient)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }
}

#Preview {
    PartnerView()
}
