import SwiftUI

struct CredibilityScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            AppTheme.Colors.background
                .ignoresSafeArea()

            FloralCornerDecoration()

            VStack(spacing: AppTheme.Spacing.sm) {
                Spacer()

                VStack(spacing: AppTheme.Spacing.xs) {
                    Text("#1")
                        .font(AppTheme.Fonts.displayLarge)
                        .foregroundColor(AppTheme.Colors.primaryPink)

                    Text("female")
                        .font(AppTheme.Fonts.largeTitle)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Text("OB-GYN-recommended")
                        .font(AppTheme.Fonts.largeTitle)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .fontWeight(.bold)

                    Text("app for period and cycle tracking")
                        .font(AppTheme.Fonts.title3)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

                Spacer()

                Text("Based on a survey of 225 US OB-GYNs who recommend apps for period and cycle tracking, DRG, 2021")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppTheme.Spacing.xxl)
                    .padding(.bottom, AppTheme.Spacing.xl)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            coordinator.advance()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                coordinator.advance()
            }
        }
    }
}

#Preview {
    CredibilityScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
