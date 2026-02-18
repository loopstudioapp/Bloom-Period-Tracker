import SwiftUI

struct BodyAwarenessScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options = [
        "Before my period",
        "During my period",
        "After my period",
        "I don't know"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            Text("74% say Bloom helps them be more in tune with their bodies.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.top, AppTheme.Spacing.md)

            Text("When do you feel best in your body?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(
                            title: option,
                            isSelected: viewModel.bodyBestTime == option
                        ) {
                            viewModel.selectBodyBestTime(option)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                coordinator.advance()
                            }
                        }
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
    }
}

#Preview {
    BodyAwarenessScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
