import SwiftUI

struct PleasureInvolvementScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options = [
        "Just me",
        "Someone else too",
        "Prefer not to answer"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            Text("Last year, 3.6 million people turned to Bloom for better orgasms.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.top, AppTheme.Spacing.md)

            Text("Who's involved in your pleasure?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(
                            title: option,
                            isSelected: viewModel.pleasureInvolvement == option
                        ) {
                            viewModel.selectPleasureInvolvement(option)
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
    PleasureInvolvementScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
