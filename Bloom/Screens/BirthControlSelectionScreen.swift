import SwiftUI

struct BirthControlSelectionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    optionsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("What birth control do you use, if any?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("We're asking because some types of birth control can impact your cycle.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Options

    private var optionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(BirthControlMethod.allCases) { method in
                OptionRow(
                    title: method.rawValue,
                    isSelected: viewModel.birthControlMethodRaw == method.rawValue
                ) {
                    viewModel.selectBirthControl(method.rawValue)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        coordinator.advance()
                    }
                }
            }
        }
    }
}

#Preview {
    BirthControlSelectionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
