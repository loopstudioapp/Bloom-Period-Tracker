import SwiftUI

struct CycleSexLifeScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options = ["Yes", "No", "I don't know"]

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
            Text("62% say Bloom helps them understand the link between their cycle and their desire for sex.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.top, AppTheme.Spacing.md)

            Text("Do you know how your cycle relates to your sex life?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(showsIndicators: false) {
                VStack(spacing: AppTheme.Spacing.sm) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(
                            title: option,
                            isSelected: viewModel.cycleSexKnowledge == option
                        ) {
                            viewModel.selectCycleSexKnowledge(option)
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
    CycleSexLifeScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
