import SwiftUI

struct ThankYouHonestyScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private var capitalizedName: String {
        let name = viewModel.displayName
        guard let first = name.first else { return name }
        return String(first).uppercased() + name.dropFirst()
    }

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            SparklingHeart()

            Spacer()
                .frame(height: AppTheme.Spacing.xxl)

            Text("\(capitalizedName), thanks for being so honest")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

            Spacer()
                .frame(height: AppTheme.Spacing.md)

            Text("We're ready to make your sexual experiences more pleasurable, intuitive and fun!")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

            Spacer()

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.backgroundWarm.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

#Preview {
    ThankYouHonestyScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
