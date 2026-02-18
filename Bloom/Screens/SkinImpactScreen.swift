import SwiftUI

struct SkinImpactScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        StatQuestionScreen(
            statText: "1 in 2 Bloom users say Bloom helps them improve their skin.",
            questionTitle: "Does your cycle impact your skin?",
            options: [
                StatQuestionOption(
                    label: "Yes",
                    expandedDescription: "We'll help you love the skin you're in! Log breakouts for tips on building a skincare routine, info on conditions like hormonal acne and what vitamins are great for healthy skin."
                ),
                StatQuestionOption(
                    label: "No",
                    expandedDescription: "That's great! Understanding how hormones affect skin can help you maintain your clear complexion throughout your cycle."
                ),
                StatQuestionOption(
                    label: "I'm not sure",
                    expandedDescription: "Many people don't realize their skin changes are cycle-related. Bloom can help you track and discover patterns."
                )
            ],
            selectedValue: viewModel.skinImpact,
            onSelect: { value in
                viewModel.selectSkinImpact(value)
            },
            onNext: {
                coordinator.advance()
            }
        )
    }
}

#Preview {
    SkinImpactScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
