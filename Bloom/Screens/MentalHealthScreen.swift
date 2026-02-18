import SwiftUI

struct MentalHealthScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options: [(title: String, description: String)] = [
        (
            "Mood swings",
            "Mood swings are one of the most common PMS symptoms. Bloom can help you track and predict when they might occur so you can better prepare."
        ),
        (
            "Anxiety",
            "Thanks to brain chemistry and hormone fluctuations, women are more likely to experience anxiety than men. Check out Bloom's video course on how to cope."
        ),
        (
            "Fatigue",
            "Feeling drained at certain points in your cycle is completely normal. Track your energy levels in Bloom and discover your personal patterns."
        ),
        (
            "Irritability",
            "Fluctuating hormones have a lot to answer for \u{2014} like how tolerant we are to irritations during PMS. Log your feelings in Bloom and see if a pattern emerges with your cycle."
        ),
        (
            "Low mood",
            "Low mood can be linked to hormonal changes in your cycle. Bloom helps you understand these connections and offers evidence-based coping strategies."
        ),
        (
            "I have Premenstrual Dysphoric Disorder",
            "PMDD is a severe form of PMS that affects 3-8% of women. Bloom can help you track symptoms to share with your healthcare provider."
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
                isEnabled: !viewModel.mentalHealthSelections.isEmpty
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
            Text("More than half of users say Bloom helps them to better understand how their cycle affects their mental health.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("Does your cycle impact any aspect of your mental health?")
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
                    isSelected: viewModel.isMentalHealthSelected(option.title)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleMentalHealth(option.title)
                    }
                }
            }
        }
    }
}

#Preview {
    MentalHealthScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
