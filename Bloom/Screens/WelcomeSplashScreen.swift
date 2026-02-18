import SwiftUI

struct WelcomeSplashScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var appeared = false
    @State private var bloomScale: CGFloat = 0.3
    @State private var bloomOpacity: Double = 0

    var body: some View {
        ZStack {
            AppTheme.Colors.splashGradient.ignoresSafeArea()

            VStack(spacing: AppTheme.Spacing.xxl) {
                Spacer()

                // Blooming flower animation
                ZStack {
                    ForEach(0..<6, id: \.self) { i in
                        Ellipse()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 40, height: 70)
                            .offset(y: -35)
                            .rotationEffect(.degrees(Double(i) * 60))
                    }

                    Circle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 30, height: 30)
                }
                .scaleEffect(bloomScale)
                .opacity(bloomOpacity)

                VStack(spacing: AppTheme.Spacing.md) {
                    Text("Welcome to")
                        .font(AppTheme.Fonts.title3)
                        .foregroundColor(AppTheme.Colors.textWhite.opacity(0.8))
                        .opacity(appeared ? 1 : 0)

                    Text("Bloom")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Colors.textWhite)
                        .opacity(appeared ? 1 : 0)

                    Text("\(viewModel.displayName), your journey to understanding your body starts now")
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textWhite.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xxl)
                        .opacity(appeared ? 1 : 0)
                }

                Spacer()
                Spacer()
            }
        }
        .onAppear {
            withAnimation(AppTheme.Animation.slow) {
                appeared = true
            }
            withAnimation(.spring(response: 1.0, dampingFraction: 0.6).delay(0.3)) {
                bloomScale = 1.0
                bloomOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                coordinator.advance()
            }
        }
    }
}

#Preview {
    WelcomeSplashScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
