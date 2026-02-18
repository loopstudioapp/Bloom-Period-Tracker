import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            AppTheme.Colors.splashGradient
                .ignoresSafeArea()

            VStack(spacing: AppTheme.Spacing.lg) {
                BloomLogoView(size: 120, petalColor: AppTheme.Colors.textWhite)

                Text("Bloom")
                    .font(AppTheme.Fonts.scriptLogo)
                    .foregroundColor(AppTheme.Colors.textWhite)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                coordinator.advance()
            }
        }
    }
}

#Preview {
    SplashScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
