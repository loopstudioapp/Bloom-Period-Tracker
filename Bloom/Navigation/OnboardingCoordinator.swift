import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    // Welcome back (shown when user returns mid-onboarding)
    case welcomeBack = -1

    // Part 1 (screens 1-20)
    case splash = 0
    case credibility
    case privacy
    case nameInput
    case greeting
    case referralSource
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
    case heightInput
    case weightInput
    case healthIntegration
    case healthKitPermission
    case personalizing

    // Part 4 (screens 61-65)
    case valueComparison
    case commitmentPledge
    case welcomeSplash
    case paywall
    case premiumConfirmation

    /// Total number of actual onboarding steps (excluding welcomeBack)
    static var onboardingStepCount: Int {
        allCases.filter { $0.rawValue >= 0 }.count
    }

    var progressFraction: CGFloat {
        guard self.rawValue > 0 else { return 0 }
        return CGFloat(self.rawValue) / CGFloat(OnboardingStep.onboardingStepCount - 1)
    }

    var showsProgressBar: Bool {
        switch self {
        case .welcomeBack, .splash, .credibility, .greeting, .trackingPermission,
             .calendarPreview, .birthControlEducation, .calculatingPredictions,
             .notificationPreview, .notificationPermission, .dischargeDiagram,
             .cyclePatterns, .symptomPrediction, .healthAssistant,
             .cycleSexEducation, .discoverPatterns, .thankYouHonesty,
             .healthIntegration, .healthKitPermission,
             .personalizing,
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
        case .welcomeBack, .splash, .credibility, .greeting, .trackingPermission, .notificationPermission,
             .thankYouHonesty, .healthKitPermission,
             .personalizing,
             .valueComparison, .commitmentPledge, .welcomeSplash, .paywall, .premiumConfirmation:
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

    private static let savedStepKey = "onboardingLastStepRawValue"
    private static let onboardingCompleteKey = "onboardingComplete"

    /// The step the user will resume to after the welcome back screen
    private var resumeStep: OnboardingStep?

    enum NavigationDirection {
        case forward, backward
    }

    init() {
        let isComplete = UserDefaults.standard.bool(forKey: Self.onboardingCompleteKey)
        if isComplete {
            // User already finished onboarding — go straight to main app
            isOnboardingComplete = true
        } else {
            let savedRaw = UserDefaults.standard.integer(forKey: Self.savedStepKey)
            // Only show welcome back if user got past the splash (step 0)
            if savedRaw > 0, let savedStep = OnboardingStep(rawValue: savedRaw) {
                // User was mid-onboarding — show welcome back screen
                resumeStep = savedStep
                currentStep = .welcomeBack
            } else {
                // Fresh start
                currentStep = .splash
            }
        }
    }

    func advance() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) else {
            completeOnboarding()
            return
        }
        navigationDirection = .forward
        withAnimation(AppTheme.Animation.standard) {
            currentStep = nextStep
        }
        persistCurrentStep()
    }

    func goBack() {
        guard let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1),
              previousStep.rawValue >= 0 else { return }
        navigationDirection = .backward
        withAnimation(AppTheme.Animation.standard) {
            currentStep = previousStep
        }
        persistCurrentStep()
    }

    func skip() {
        advance()
    }

    /// Called from the WelcomeBackScreen's "Continue" button.
    /// Jumps the user to the step where they left off.
    func continueFromSavedStep() {
        guard let step = resumeStep else {
            advance()
            return
        }
        navigationDirection = .forward
        withAnimation(AppTheme.Animation.standard) {
            currentStep = step
        }
        resumeStep = nil
    }

    // MARK: - Private

    private func persistCurrentStep() {
        // Only persist actual onboarding steps (not welcomeBack)
        guard currentStep.rawValue >= 0 else { return }
        UserDefaults.standard.set(currentStep.rawValue, forKey: Self.savedStepKey)
    }

    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: Self.onboardingCompleteKey)
        // Clean up saved step
        UserDefaults.standard.removeObject(forKey: Self.savedStepKey)
        isOnboardingComplete = true
    }
}
