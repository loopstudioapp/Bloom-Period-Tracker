import SwiftUI

struct DailyInsightsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    mockAppSection

                    mockTabBar

                    ctaSection
                }
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.backgroundWarm)
    }

    // MARK: - Mock App Section

    private var mockAppSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("My daily insights")
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(.horizontal, AppTheme.Spacing.lg)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    logSymptomsCard
                    backacheCard
                    spottingCard
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Insight Cards

    private var logSymptomsCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Image(systemName: "plus.circle.fill")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.primaryPink)

            Spacer()

            Text("Log your symptoms")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
        .padding(AppTheme.Spacing.md)
        .frame(width: 150, height: 120)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .cardShadow()
    }

    private var backacheCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.featurePeach)
                .frame(width: AppTheme.Spacing.xxl, height: AppTheme.Spacing.xxl)

            Spacer()

            Text("Let's talk backache")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
        .padding(AppTheme.Spacing.md)
        .frame(width: 150, height: 120)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .cardShadow()
    }

    private var spottingCard: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.featurePink)
                .frame(width: AppTheme.Spacing.xxl, height: AppTheme.Spacing.xxl)

            Spacer()

            Text("Spotting vs period vs. bleeding")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .lineLimit(2)
        }
        .padding(AppTheme.Spacing.md)
        .frame(width: 150, height: 120)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .cardShadow()
    }

    // MARK: - Mock Tab Bar

    private var mockTabBar: some View {
        HStack {
            ForEach(["Today", "Insights", "Secret C..."], id: \.self) { tab in
                Text(tab)
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(
                        tab == "Today"
                            ? AppTheme.Colors.primaryPink
                            : AppTheme.Colors.textTertiary
                    )
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, AppTheme.Spacing.sm)
        .padding(.horizontal, AppTheme.Spacing.lg)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .padding(.horizontal, AppTheme.Spacing.lg)
        .cardShadow()
    }

    // MARK: - CTA Section

    private var ctaSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Bloom is so much more than a period tracker")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("We'll help you improve everything from your symptoms to your sex life.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    DailyInsightsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
