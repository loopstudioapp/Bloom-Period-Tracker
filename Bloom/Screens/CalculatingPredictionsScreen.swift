import SwiftUI

struct CalculatingPredictionsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var titleOpacity: Double = 1.0

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            illustrationSection

            Spacer()

            textSection

            Spacer()

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            withAnimation(
                SwiftUI.Animation
                    .easeInOut(duration: 1.2)
                    .repeatForever(autoreverses: true)
            ) {
                titleOpacity = 0.5
            }
        }
    }

    // MARK: - Illustration

    private var illustrationSection: some View {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.featureLightBlue)
                .frame(width: 160, height: 160)

            ZStack {
                Image(systemName: "calendar")
                    .font(.system(size: 52))
                    .foregroundColor(AppTheme.Colors.blueAccent)

                Image(systemName: "magnifyingglass")
                    .font(.system(size: 28))
                    .foregroundColor(AppTheme.Colors.primaryPink)
                    .offset(x: AppTheme.Spacing.lg, y: AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Text

    private var textSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("Calculating your cycle predictions...")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .opacity(titleOpacity)

            Text("89% of users say Bloom has helped them feel more informed and educated about their cycle health.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}

#Preview {
    CalculatingPredictionsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
