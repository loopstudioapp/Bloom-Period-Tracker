import SwiftUI

struct HelpPreferencesScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let columns = [
        GridItem(.flexible(), spacing: AppTheme.Spacing.md),
        GridItem(.flexible(), spacing: AppTheme.Spacing.md)
    ]

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    headerSection

                    preferencesGrid
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                isEnabled: !viewModel.selectedHelpPreferences.isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            if viewModel.selectedHelpPreferences.isEmpty {
                viewModel.toggleHelpPreference(.masturbation)
                viewModel.toggleHelpPreference(.decodeDischarge)
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("What can we help you do?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("Choose as many as you'd like.")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Preferences Grid

    private var preferencesGrid: some View {
        LazyVGrid(columns: columns, spacing: AppTheme.Spacing.md) {
            ForEach(HelpPreference.allCases) { pref in
                OptionCard(
                    title: pref.rawValue,
                    iconName: pref.iconName,
                    isSelected: viewModel.isHelpPreferenceSelected(pref)
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleHelpPreference(pref)
                    }
                }
            }
        }
    }
}

#Preview {
    HelpPreferencesScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
