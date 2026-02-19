import SwiftUI

struct BirthYearScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let yearRange: ClosedRange<Int> = 1940...2012

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            VStack(spacing: AppTheme.Spacing.sm) {
                Text("When were you born?")
                    .font(AppTheme.Fonts.title1)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Text("Your cycle can change with age. Knowing it helps us make better predictions.")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppTheme.Spacing.xl)
            }

            Picker("Birth Year", selection: $viewModel.birthYear) {
                ForEach(yearRange, id: \.self) { year in
                    Text(String(year))
                        .font(AppTheme.Fonts.title2)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                        .tag(year)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: AppTheme.ResponsiveLayout.scaled(200))
            .padding(.horizontal, AppTheme.Spacing.xxl)

            Spacer()

            PillButton(title: "Next") {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
    }
}

#Preview {
    BirthYearScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
