import SwiftUI

struct PeriodRegularityScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options: [(label: String, description: String)] = [
        (
            "Yes",
            "Great! We'll let you know when your period is about to start and what symptoms to expect so you can discover how your cycle impacts your life."
        ),
        (
            "No",
            "That's okay! Bloom can help you track your cycle and understand what's happening with your body."
        ),
        (
            "I don't know",
            "No worries! By tracking your cycle with Bloom, you'll soon learn your patterns."
        )
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    optionsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                isEnabled: viewModel.periodRegularity != nil
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
            Text("Are your periods regular?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("This would mean the gap between your periods is around the same number of days each month.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Options

    private var optionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(options, id: \.label) { option in
                let isSelected = viewModel.periodRegularity == option.label
                SelectableOptionRow(
                    title: option.label,
                    description: isSelected ? option.description : nil,
                    isSelected: isSelected
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.selectPeriodRegularity(option.label)
                    }
                }
            }
        }
    }
}

#Preview {
    PeriodRegularityScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
