import SwiftUI

struct HeightInputScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var selectedFeet: Int = 5
    @State private var selectedInches: Int = 4

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            Text("How tall are you?")
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)

            displayCard

            pickerSection

            Spacer()

            PillButton(title: "Next") {
                viewModel.heightFeet = selectedFeet
                viewModel.heightInches = selectedInches
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            selectedFeet = viewModel.heightFeet
            selectedInches = viewModel.heightInches
        }
    }

    // MARK: - Display Card

    private var displayCard: some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            Text("\(selectedFeet)")
                .font(AppTheme.Fonts.largeTitle)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("ft")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text("\(selectedInches)")
                .font(AppTheme.Fonts.largeTitle)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Text("in")
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
            Picker("Feet", selection: $selectedFeet) {
                ForEach(3...7, id: \.self) { feet in
                    Text("\(feet) ft").tag(feet)
                }
            }
            .pickerStyle(.wheel)

            Picker("Inches", selection: $selectedInches) {
                ForEach(0...11, id: \.self) { inches in
                    Text("\(inches) in").tag(inches)
                }
            }
            .pickerStyle(.wheel)
        }
        .padding(.horizontal, AppTheme.Spacing.xl)
    }
}

#Preview {
    HeightInputScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
