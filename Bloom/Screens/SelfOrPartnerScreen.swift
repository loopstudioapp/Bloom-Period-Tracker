import SwiftUI

struct SelfOrPartnerScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            Text("Are you using Bloom\nfor yourself?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

            VStack(spacing: AppTheme.Spacing.sm) {
                ForEach(TrackingFor.allCases) { option in
                    OptionRow(
                        title: option.rawValue,
                        isSelected: viewModel.trackingForRaw == option.rawValue
                    ) {
                        viewModel.trackingForRaw = option.rawValue
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            coordinator.advance()
                        }
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)

            Spacer()
        }
    }
}

#Preview {
    SelfOrPartnerScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
