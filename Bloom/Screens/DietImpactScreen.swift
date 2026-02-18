import SwiftUI

struct DietImpactScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        StatQuestionScreen(
            statText: "66% of users say Bloom helps them improve their diet.",
            questionTitle: "Does your cycle impact your diet?",
            options: [
                StatQuestionOption(
                    label: "Yes",
                    expandedDescription: "Ever wondered why you're more hungry before your period? Or if there's anything to eat to ease PMS? Check out our articles and videos from dieticians to sync your diet with your cycle."
                ),
                StatQuestionOption(
                    label: "No",
                    expandedDescription: ""
                ),
                StatQuestionOption(
                    label: "I'm not sure",
                    expandedDescription: ""
                )
            ],
            selectedValue: viewModel.dietImpact,
            onSelect: { value in
                viewModel.selectDietImpact(value)
            },
            onNext: {
                coordinator.advance()
            }
        )
    }
}

#Preview {
    DietImpactScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
