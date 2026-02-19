import SwiftUI

struct PersonalizingScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var progress: Double = 0.0
    @State private var currentPhase: Int = 0
    @State private var timer: Timer?

    private let phaseTitles = [
        "Get daily personalised insights on your cycle",
        "Chat with our virtual Health Assistant for instant advice",
        "Find answers to your most intimate questions",
        "Know your data and privacy is our No.1 priority"
    ]

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xxl) {
            Spacer()

            phaseContent
                .frame(height: AppTheme.ResponsiveLayout.scaled(200))
                .clipped()

            CircularProgressView(progress: progress)

            Text("Personalizing your experience...")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
        .background(AppTheme.Colors.background)
        .navigationBarHidden(true)
        .onAppear {
            startProgressTimer()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    // MARK: - Phase Content

    @ViewBuilder
    private var phaseContent: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Group {
                switch currentPhase {
                case 0:
                    ArticleCardsCollage()
                case 1:
                    HealthAssistantPhoneIllustration()
                case 2:
                    IntimateQuestionsIllustration()
                default:
                    ISOShieldBadge()
                }
            }
            .transition(.opacity)

            Text(phaseTitles[currentPhase])
                .font(AppTheme.Fonts.title3)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .transition(.opacity)
                .id("phase-title-\(currentPhase)")
        }
        .animation(.easeInOut(duration: 0.5), value: currentPhase)
    }

    // MARK: - Timer

    private func startProgressTimer() {
        let totalDuration: Double = 4.5
        let tickInterval: Double = 0.05
        let increment = tickInterval / totalDuration

        timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { t in
            progress += increment

            let newPhase: Int
            if progress < 0.25 {
                newPhase = 0
            } else if progress < 0.50 {
                newPhase = 1
            } else if progress < 0.90 {
                newPhase = 2
            } else {
                newPhase = 3
            }

            if newPhase != currentPhase {
                withAnimation(.easeInOut(duration: 0.5)) {
                    currentPhase = newPhase
                }
            }

            if progress >= 1.0 {
                t.invalidate()
                timer = nil
                coordinator.advance()
            }
        }
    }
}

#Preview {
    PersonalizingScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
