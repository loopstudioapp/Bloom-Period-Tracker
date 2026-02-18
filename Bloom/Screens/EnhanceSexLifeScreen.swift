import SwiftUI

struct EnhanceSexLifeScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options = [
        "I want to feel more connected during sex",
        "I want to have more orgasms",
        "I want to make sex more fun",
        "I want to feel more confident sexually",
        "Prefer not to answer"
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    optionsSection
                }
                .padding(.horizontal, AppTheme.Spacing.xl)
                .padding(.top, AppTheme.Spacing.md)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                style: .primary,
                isEnabled: !viewModel.enhanceSexLifeSelections.isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("1 in 4 say Bloom helped them feel more satisfied with their sex life.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("How would you like to enhance your sex life?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Options

    private var optionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(options, id: \.self) { option in
                SelectableOptionRow(
                    title: option,
                    isSelected: viewModel.isEnhanceSexLifeSelected(option)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleEnhanceSexLife(option)
                    }
                }
            }
        }
    }
}

#Preview {
    EnhanceSexLifeScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
