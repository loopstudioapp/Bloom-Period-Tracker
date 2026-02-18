import SwiftUI

struct CycleEducationScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let phases = OnboardingData.cyclePhases

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.xl) {
                    titleSection

                    MoodCycleChart()

                    phaseBar

                    educationSection
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

    // MARK: - Title

    private var titleSection: some View {
        Text("\(viewModel.displayName), next we'll look at your cycle")
            .font(AppTheme.Fonts.title1)
            .foregroundColor(AppTheme.Colors.textPrimary)
            .multilineTextAlignment(.center)
    }

    // MARK: - Phase Bar

    private var phaseBar: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            GeometryReader { geometry in
                HStack(spacing: AppTheme.Spacing.xxs) {
                    ForEach(phases) { phase in
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                            .fill(phase.color)
                            .frame(
                                width: geometry.size.width * phase.widthFraction
                                    - AppTheme.Spacing.xxs,
                                height: AppTheme.Spacing.sm
                            )
                    }
                }
            }
            .frame(height: AppTheme.Spacing.sm)

            HStack(spacing: .zero) {
                ForEach(phases) { phase in
                    Text(phase.name)
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    // MARK: - Education Section

    private var educationSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Your cycle is made up of 4 stages")
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            Text("Each stage is driven by different hormones that affect how you feel. By logging your symptoms, Bloom learns your unique patterns.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CycleEducationScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
