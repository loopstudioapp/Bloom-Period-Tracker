import SwiftUI

struct NameInputScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel
    @FocusState private var isNameFieldFocused: Bool

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            VStack(spacing: AppTheme.Spacing.sm) {
                Text("Let's get to know each other!")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Text("What would you like\nBloom to call you?")
                    .font(AppTheme.Fonts.title1)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
            }

            TextField("Julia", text: $viewModel.userName)
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.optionBackground)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
                .padding(.horizontal, AppTheme.Spacing.xl)
                .focused($isNameFieldFocused)

            Spacer()

            PillButton(
                title: "Continue",
                isEnabled: !viewModel.userName.trimmingCharacters(in: .whitespaces).isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isNameFieldFocused = true
            }
        }
    }
}

#Preview {
    NameInputScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
