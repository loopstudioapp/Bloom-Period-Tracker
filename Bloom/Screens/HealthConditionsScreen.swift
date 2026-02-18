import SwiftUI

struct HealthConditionsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    conditionsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                isEnabled: !viewModel.healthConditions.isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Do you suffer from any of these health conditions?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Choose all that apply.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Conditions

    private var conditionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(HealthCondition.allCases) { condition in
                SelectableOptionRow(
                    title: condition.rawValue,
                    isSelected: viewModel.isHealthConditionSelected(condition.rawValue)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        if condition == .none {
                            // Exclusive toggle: clear all others and select "none"
                            let wasSelected = viewModel.isHealthConditionSelected(condition.rawValue)
                            viewModel.healthConditions = []
                            if !wasSelected {
                                viewModel.toggleHealthCondition(condition.rawValue)
                            }
                        } else {
                            // Remove "none" if selecting a real condition
                            if viewModel.isHealthConditionSelected(HealthCondition.none.rawValue) {
                                viewModel.healthConditions.remove(HealthCondition.none.rawValue)
                            }
                            viewModel.toggleHealthCondition(condition.rawValue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HealthConditionsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
