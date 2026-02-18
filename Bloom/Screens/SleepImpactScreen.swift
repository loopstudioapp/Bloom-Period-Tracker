import SwiftUI

struct SleepImpactScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        StatQuestionScreen(
            statText: "69% of users say Bloom helps them sleep better.",
            questionTitle: "Does your cycle impact your sleep?",
            options: [
                StatQuestionOption(
                    label: "Yes",
                    expandedDescription: "We hear you — cycle-related sleep disruptions are common. Bloom can help you track patterns and find tips for better rest."
                ),
                StatQuestionOption(
                    label: "No",
                    expandedDescription: "We love that you aren't losing sleep because of your cycle. For an even more satisfying snooze, check out Bloom's sleep audios and tips and tricks."
                ),
                StatQuestionOption(
                    label: "I'm not sure",
                    expandedDescription: "That's okay! By tracking your sleep alongside your cycle, Bloom can help you discover if there's a connection."
                )
            ],
            selectedValue: viewModel.sleepImpact,
            onSelect: { value in
                viewModel.selectSleepImpact(value)
            },
            onNext: {
                coordinator.advance()
            }
        )
    }
}

#Preview {
    SleepImpactScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
