import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    // Part 1 (screens 1-20)
    case splash = 0
    case credibility
    case privacy
    case nameInput
    case greeting
    case referralSource
    case selfOrPartner
    case trackingPermission
    case pregnancyStatus
    case birthYear
    case featurePreview
    case trackingGoals
    case periodPrediction
    case reviews
    case dailyInsights
    case helpPreferences
    case confirmation
    case periodFeelings
    case communityPreview
    case cycleEducation

    // Part 2 (screens 21-40)
    case periodRegularity
    case calendarPreview
    case periodDateSelection
    case periodDateSelectionPrevious
    case birthControlSelection
    case birthControlEducation
    case healthConditions
    case calculatingPredictions
    case notificationPreview
    case notificationPermission
    case dischargeAwareness
    case dischargeDiagram
    case cyclePatterns
    case symptomSelection
    case symptomPrediction
    case cycleRelatedSymptoms
    case healthAssistant
    case sleepImpact
    case skinImpact
    case energyImpact

    // Part 3 (screens 41-60)
    case dietImpact
    case mentalHealth
    case sexualWellness
    case cycleSexEducation
    case cycleSexLife
    case bodyAwareness
    case sexDriveFluctuation
    case enhanceSexLife
    case pleasureInvolvement
    case discoverPatterns
    case thankYouHonesty
    case partnerInvite
    case heightInput
    case weightInput
    case healthIntegration
    case healthKitPermission
    case personalizingPhase1
    case personalizingPhase2
    case personalizingPhase3
    case personalizingPhase4

    // Part 4 (screens 61-65)
    case valueComparison
    case commitmentPledge
    case welcomeSplash
    case paywall
    case premiumConfirmation

    var progressFraction: CGFloat {
        guard self.rawValue > 0 else { return 0 }
        return CGFloat(self.rawValue) / CGFloat(OnboardingStep.allCases.count - 1)
    }

    var showsProgressBar: Bool {
        switch self {
        case .splash, .credibility, .greeting, .trackingPermission,
             .calendarPreview, .birthControlEducation, .calculatingPredictions,
             .notificationPreview, .notificationPermission, .dischargeDiagram,
             .cyclePatterns, .symptomPrediction, .healthAssistant,
             .cycleSexEducation, .discoverPatterns, .thankYouHonesty,
             .partnerInvite, .healthIntegration, .healthKitPermission,
             .personalizingPhase1, .personalizingPhase2, .personalizingPhase3, .personalizingPhase4,
             .valueComparison, .commitmentPledge, .welcomeSplash, .paywall, .premiumConfirmation:
            return false
        default:
            return true
        }
    }

    var showsSkipButton: Bool {
        switch self {
        case .nameInput, .referralSource, .trackingGoals, .helpPreferences, .periodFeelings,
             .periodRegularity, .birthControlSelection, .healthConditions,
             .dischargeAwareness, .symptomSelection, .cycleRelatedSymptoms,
             .sleepImpact, .skinImpact, .energyImpact,
             .dietImpact, .mentalHealth, .sexualWellness,
             .cycleSexLife, .bodyAwareness, .sexDriveFluctuation,
             .enhanceSexLife, .pleasureInvolvement,
             .heightInput, .weightInput:
            return true
        default:
            return false
        }
    }

    var showsBackButton: Bool {
        switch self {
        case .splash, .credibility, .greeting, .trackingPermission, .notificationPermission,
             .thankYouHonesty, .healthKitPermission,
             .personalizingPhase1, .personalizingPhase2, .personalizingPhase3, .personalizingPhase4,
             .valueComparison, .commitmentPledge, .welcomeSplash, .premiumConfirmation:
            return false
        default:
            return true
        }
    }
}

@MainActor
class OnboardingCoordinator: ObservableObject {
    @Published var currentStep: OnboardingStep = .splash
    @Published var isOnboardingComplete = false
    @Published var navigationDirection: NavigationDirection = .forward

    enum NavigationDirection {
        case forward, backward
    }

    func advance() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) else {
            isOnboardingComplete = true
            return
        }
        navigationDirection = .forward
        withAnimation(AppTheme.Animation.standard) {
            currentStep = nextStep
        }
    }

    func goBack() {
        guard let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1) else { return }
        navigationDirection = .backward
        withAnimation(AppTheme.Animation.standard) {
            currentStep = previousStep
        }
    }

    func skip() {
        advance()
    }
}
