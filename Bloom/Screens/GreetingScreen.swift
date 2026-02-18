import SwiftUI

struct GreetingScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var isVisible = false

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            BloomLogoView(size: 60, petalColor: AppTheme.Colors.primaryPink)

            Text("Nice to meet you, \(viewModel.displayName)!")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

            Spacer()
        }
        .opacity(isVisible ? 1.0 : 0.0)
        .animation(AppTheme.Animation.slow, value: isVisible)
        .onAppear {
            isVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                coordinator.advance()
            }
        }
    }
}

#Preview {
    GreetingScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
