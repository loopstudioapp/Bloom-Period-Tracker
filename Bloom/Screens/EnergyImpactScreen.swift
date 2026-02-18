import SwiftUI

struct EnergyImpactScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        StatQuestionScreen(
            statText: "Bloom is the #1 Health and Fitness app in the USA and the UK.",
            questionTitle: "Does your cycle impact your energy or activity levels?",
            options: [
                StatQuestionOption(
                    label: "Yes",
                    expandedDescription: "Your cycle has a big impact on energy levels! Bloom will help you understand when to push hard and when to rest."
                ),
                StatQuestionOption(
                    label: "No",
                    expandedDescription: "That's great! Check out the best workouts to meet your fitness goals at every stage of your cycle in Bloom."
                ),
                StatQuestionOption(
                    label: "I'm not sure",
                    expandedDescription: "Many people don't realize their energy fluctuations are cycle-related. Bloom can help you track and optimize your activity."
                )
            ],
            selectedValue: viewModel.energyImpact,
            onSelect: { value in
                viewModel.selectEnergyImpact(value)
            },
            onNext: {
                coordinator.advance()
            }
        )
    }
}

#Preview {
    EnergyImpactScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
