import SwiftUI

struct ReferralSourceScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Text("How did you find out\nabout us?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, AppTheme.Spacing.md)

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(ReferralSource.allCases) { source in
                        OptionRow(
                            title: source.rawValue,
                            isSelected: viewModel.referralSourceRaw == source.rawValue
                        ) {
                            viewModel.referralSourceRaw = source.rawValue
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                coordinator.advance()
                            }
                        }
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }
}

#Preview {
    ReferralSourceScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
