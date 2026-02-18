import SwiftUI

struct SymptomPredictionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    previewSection

                    textSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("How you might feel tomorrow")
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .opacity(0.6)

            Text("Based on your cycle patterns, here is a preview of insights Bloom can provide.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .opacity(0.6)

            tomorrowSymptomsCard
        }
        .padding(AppTheme.Spacing.lg)
        .background(AppTheme.Colors.backgroundPink)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    private var tomorrowSymptomsCard: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("Tomorrow's symptoms")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            HStack(spacing: AppTheme.Spacing.md) {
                ForEach(0..<3, id: \.self) { _ in
                    Circle()
                        .fill(AppTheme.Colors.dischargePurpleLight)
                        .frame(width: 40, height: 40)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Spacing.lg)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
    }

    // MARK: - Text Section

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Always be ready for what's coming")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("When you log your symptoms, Bloom helps you spot patterns so you can plan life around how you may feel next week — or even next cycle.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SymptomPredictionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
