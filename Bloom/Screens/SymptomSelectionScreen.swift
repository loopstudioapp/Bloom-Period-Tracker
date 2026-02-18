import SwiftUI

struct SymptomSelectionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    symptomCard
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Your cycle can impact how you feel.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("\(viewModel.displayName), how do you feel today?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Symptom Card

    private var symptomCard: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("Select your symptoms")
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)

            SymptomGrid(
                symptoms: OnboardingData.todaySymptoms,
                selectedSymptoms: viewModel.todaySymptoms,
                onToggle: { symptom in
                    viewModel.toggleTodaySymptom(symptom)
                },
                onApply: {
                    coordinator.advance()
                }
            )
        }
        .padding(AppTheme.Spacing.lg)
        .background(AppTheme.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .cardShadow()
    }
}

#Preview {
    SymptomSelectionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
