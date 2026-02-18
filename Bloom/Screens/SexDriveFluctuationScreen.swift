import SwiftUI

struct SexDriveFluctuationScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options = [
        "Yes, it does",
        "No, it stays the same",
        "I don't know"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            Text("64% of Premium users say Bloom helped them understand when their sex drive is highest.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.top, AppTheme.Spacing.md)

            Text("Does your sex drive fluctuate throughout the month?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(
                            title: option,
                            isSelected: viewModel.sexDriveFluctuates == option
                        ) {
                            viewModel.selectSexDriveFluctuates(option)
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
    SexDriveFluctuationScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
