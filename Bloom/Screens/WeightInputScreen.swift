import SwiftUI

struct WeightInputScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var selectedPounds: Int = 130
    @State private var selectedDecimal: Int = 0

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            Text("How much do you weigh?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            displayCard

            pickerSection

            Spacer()

            PillButton(title: "Next") {
                viewModel.weightPounds = selectedPounds
                viewModel.weightDecimal = selectedDecimal
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            selectedPounds = viewModel.weightPounds
            selectedDecimal = viewModel.weightDecimal
        }
    }

    // MARK: - Display Card

    private var displayCard: some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            Text("\(selectedPounds)")
                .font(AppTheme.Fonts.largeTitle)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text(".")
                .font(AppTheme.Fonts.largeTitle)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("\(selectedDecimal)")
                .font(AppTheme.Fonts.largeTitle)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("lb")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Spacing.xl)
        .background(AppTheme.Colors.optionBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
        .padding(.horizontal, AppTheme.Spacing.xl)
    }

    // MARK: - Picker Section

    private var pickerSection: some View {
        HStack(spacing: .zero) {
            Picker("Pounds", selection: $selectedPounds) {
                ForEach(80...350, id: \.self) { pounds in
                    Text("\(pounds)").tag(pounds)
                }
            }
            .pickerStyle(.wheel)

            Picker("Decimal", selection: $selectedDecimal) {
                ForEach(0...9, id: \.self) { decimal in
                    Text(".\(decimal)").tag(decimal)
                }
            }
            .pickerStyle(.wheel)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
    }
}

#Preview {
    WeightInputScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
