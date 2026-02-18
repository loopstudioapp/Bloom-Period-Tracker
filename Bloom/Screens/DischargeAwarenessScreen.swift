import SwiftUI

struct DischargeAwarenessScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    private let options: [(label: String, description: String)] = [
        (
            "Yes",
            "That's great that you're aware! We'll help you track changes and understand what's normal."
        ),
        (
            "No",
            "It's totally normal to have discharge and it changes throughout your cycle. The texture, color and odor of your discharge can tell you a lot about your reproductive health."
        )
    ]

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

            PillButton(
                title: "Next",
                isEnabled: viewModel.dischargeAwareness != nil
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            if viewModel.dischargeAwareness == nil {
                viewModel.selectDischargeAwareness("No")
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        Text("Did you know your discharge changes throughout your cycle?")
            .font(AppTheme.Fonts.title1)
            .foregroundColor(AppTheme.Colors.textPrimary)
            .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Options

    private var optionsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(options, id: \.label) { option in
                let isSelected = viewModel.dischargeAwareness == option.label
                SelectableOptionRow(
                    title: option.label,
                    description: isSelected ? option.description : nil,
                    isSelected: isSelected
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.selectDischargeAwareness(option.label)
                    }
                }
            }
        }
    }
}

#Preview {
    DischargeAwarenessScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
