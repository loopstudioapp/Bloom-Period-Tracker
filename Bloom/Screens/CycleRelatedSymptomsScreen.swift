import SwiftUI

struct CycleRelatedSymptomsScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    statSection

                    headerSection

                    symptomsSection
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.top, AppTheme.Spacing.xl)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }

            PillButton(
                title: "Next",
                isEnabled: !viewModel.cycleRelatedSymptoms.isEmpty
            ) {
                coordinator.advance()
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            if viewModel.cycleRelatedSymptoms.isEmpty {
                viewModel.toggleCycleSymptom(CycleSymptom.spotting.rawValue)
            }
        }
    }

    // MARK: - Stat

    private var statSection: some View {
        Text("71% of users said the app helps them improve how they manage menstrual symptoms.")
            .font(AppTheme.Fonts.subheadline)
            .foregroundColor(AppTheme.Colors.textSecondary)
    }

    // MARK: - Header

    private var headerSection: some View {
        Text("Do you experience any cycle-related symptoms?")
            .font(AppTheme.Fonts.title1)
            .foregroundColor(AppTheme.Colors.textPrimary)
            .padding(.bottom, AppTheme.Spacing.sm)
    }

    // MARK: - Symptoms List

    private var symptomsSection: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            ForEach(CycleSymptom.allCases) { symptom in
                let isSelected = viewModel.isCycleSymptomSelected(symptom.rawValue)
                SelectableOptionRow(
                    title: symptom.rawValue,
                    description: isSelected ? symptom.expandedDescription : nil,
                    isSelected: isSelected
                ) {
                    withAnimation(AppTheme.Animation.standard) {
                        viewModel.toggleCycleSymptom(symptom.rawValue)
                    }
                }
            }
        }
    }
}

#Preview {
    CycleRelatedSymptomsScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
