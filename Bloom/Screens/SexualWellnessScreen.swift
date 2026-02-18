import SwiftUI

struct SexualWellnessScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options: [(title: String, description: String)] = [
        (
            "Better orgasms",
            "Understanding your cycle can help you discover when arousal peaks. Bloom offers insights from sex therapists on enhancing pleasure."
        ),
        (
            "Improved sex drive",
            "Fluctuating libido is perfectly normal but can feel like a mystery. Log it in Bloom to see if it changes during your cycle, plus get tips to boost your sex drive from Bloom's sex therapists."
        ),
        (
            "Increased intimacy",
            "Strong communication is vital to great partnered sex but takes effort and practice! Bloom offers sexpert-approved tips on how to communicate your needs and find out theirs."
        ),
        (
            "Sex positions",
            "Explore different positions that work better at different phases of your cycle. Bloom provides curated suggestions from certified sex educators."
        ),
        (
            "Make sex less painful",
            "Pain during sex is common but not normal. Bloom can help you track when it occurs and offers resources from healthcare professionals."
        )
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    optionsSection
                }
                .padding(.horizontal, AppTheme.Spacing.xl)
                .padding(.top, AppTheme.Spacing.md)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                style: .primary,
                isEnabled: !viewModel.sexualWellnessSelections.isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Nearly 1 in 4 users say Bloom helps them learn more about pleasure during sex.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("Do you want to change anything about your sex life?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Options

    private var optionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(options, id: \.title) { option in
                SelectableOptionRow(
                    title: option.title,
                    description: option.description,
                    isSelected: viewModel.isSexualWellnessSelected(option.title)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleSexualWellness(option.title)
                    }
                }
            }
        }
    }
}

#Preview {
    SexualWellnessScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
