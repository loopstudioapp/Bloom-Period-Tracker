import SwiftUI

struct TrackingGoalsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    goalsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(title: "Next", isEnabled: !viewModel.selectedGoals.isEmpty) {
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
            Text("Why are you tracking your cycle?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Choose as many as you like.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Goals List

    private var goalsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(TrackingGoal.allCases) { goal in
                SelectableOptionRow(
                    title: goal.rawValue,
                    description: viewModel.isGoalSelected(goal) ? goal.description : nil,
                    isSelected: viewModel.isGoalSelected(goal)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleGoal(goal)
                    }
                }
            }
        }
    }
}

#Preview {
    TrackingGoalsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
