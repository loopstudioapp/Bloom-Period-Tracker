import SwiftUI

struct ConfirmationScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            VStack(spacing: AppTheme.Spacing.xl) {
                WomanHoldingPhoneIllustration()

                titleSection

                summarySection
            }
            .padding(.horizontal, AppTheme.Spacing.lg)

            Spacer()

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Title

    private var titleSection: some View {
        Text("Got it! We'll help you:")
            .font(AppTheme.Fonts.title1)
            .foregroundColor(AppTheme.Colors.textPrimary)
            .multilineTextAlignment(.center)
    }

    // MARK: - Summary

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            ForEach(viewModel.confirmationSummary, id: \.self) { item in
                HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppTheme.Colors.primaryPink)
                        .font(AppTheme.Fonts.body)

                    Text(item)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

#Preview {
    ConfirmationScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
