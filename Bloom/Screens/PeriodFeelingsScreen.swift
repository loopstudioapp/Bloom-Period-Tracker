import SwiftUI

struct PeriodFeelingsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    feelingsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                isEnabled: viewModel.periodFeeling != nil
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
        Text("How do you feel about your period, \(viewModel.displayName)?")
            .font(AppTheme.Fonts.title1)
            .foregroundColor(AppTheme.Colors.textPrimary)
            .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Feelings List

    private var feelingsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(PeriodFeeling.allCases) { feeling in
                SelectableOptionRow(
                    title: "\(feeling.rawValue) \(feeling.emoji)",
                    description: viewModel.isPeriodFeelingSelected(feeling) ? feeling.description : nil,
                    isSelected: viewModel.isPeriodFeelingSelected(feeling)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.selectPeriodFeeling(feeling)
                    }
                }
            }
        }
    }
}

#Preview {
    PeriodFeelingsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
