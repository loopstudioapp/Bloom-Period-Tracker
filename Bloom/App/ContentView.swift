import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = OnboardingCoordinator()
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        Group {
            if coordinator.isOnboardingComplete {
                BloomTabView()
                    .environmentObject(viewModel)
                    .transition(.opacity)
            } else {
                onboardingView
                    .environmentObject(coordinator)
                    .environmentObject(viewModel)
                    .transition(.opacity)
            }
        }
        .animation(AppTheme.Animation.standard, value: coordinator.isOnboardingComplete)
    }

    // MARK: - Onboarding View
    private var onboardingView: some View {
        ZStack {
            AppTheme.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top navigation bar
                if coordinator.currentStep.showsProgressBar || coordinator.currentStep.showsBackButton || coordinator.currentStep.showsSkipButton {
                    topBar
                        .padding(.horizontal, AppTheme.Spacing.lg)
                        .padding(.top, AppTheme.Spacing.sm)
                        .padding(.bottom, AppTheme.Spacing.xs)
                }

                // Screen content
                screenContent
                    .constrainedWidth()
            }
        }
    }

    // MARK: - Top Bar
    private var topBar: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            HStack {
                if coordinator.currentStep.showsBackButton {
                    Button(action: { coordinator.goBack() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                } else {
                    Spacer().frame(width: 44)
                }

                Spacer()

                if coordinator.currentStep.showsSkipButton {
                    Button(action: { coordinator.skip() }) {
                        Text("Skip")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }
            }

            if coordinator.currentStep.showsProgressBar {
                ProgressBar(progress: coordinator.currentStep.progressFraction)
            }
        }
    }

    // MARK: - Screen Content
    @ViewBuilder
    private var screenContent: some View {
        Group {
            switch coordinator.currentStep {
            // Welcome Back (resume from where user left off)
            case .welcomeBack:
                WelcomeBackScreen()
            // Part 1
            case .splash:
                SplashScreen()
            case .credibility:
                CredibilityScreen()
            case .privacy:
                PrivacyScreen()
            case .nameInput:
                NameInputScreen()
            case .greeting:
                GreetingScreen()
            case .referralSource:
                ReferralSourceScreen()
            case .trackingPermission:
                TrackingPermissionScreen()
            case .pregnancyStatus:
                PregnancyStatusScreen()
            case .birthYear:
                BirthYearScreen()
            case .featurePreview:
                FeaturePreviewScreen()
            case .trackingGoals:
                TrackingGoalsScreen()
            case .periodPrediction:
                PeriodPredictionScreen()
            case .reviews:
                ReviewsScreen()
            case .dailyInsights:
                DailyInsightsScreen()
            case .helpPreferences:
                HelpPreferencesScreen()
            case .confirmation:
                ConfirmationScreen()
            case .periodFeelings:
                PeriodFeelingsScreen()
            case .cycleEducation:
                CycleEducationScreen()
            // Part 2
            case .periodRegularity:
                PeriodRegularityScreen()
            case .calendarPreview:
                CalendarPreviewScreen()
            case .periodDateSelection:
                PeriodDateSelectionScreen()
            case .periodDateSelectionPrevious:
                PeriodDateSelectionPreviousScreen()
            case .birthControlSelection:
                BirthControlSelectionScreen()
            case .birthControlEducation:
                BirthControlEducationScreen()
            case .healthConditions:
                HealthConditionsScreen()
            case .calculatingPredictions:
                CalculatingPredictionsScreen()
            case .notificationPreview:
                NotificationPreviewScreen()
            case .notificationPermission:
                NotificationPermissionScreen()
            case .dischargeAwareness:
                DischargeAwarenessScreen()
            case .dischargeDiagram:
                DischargeDiagramScreen()
            case .cyclePatterns:
                CyclePatternsScreen()
            case .symptomSelection:
                SymptomSelectionScreen()
            case .symptomPrediction:
                SymptomPredictionScreen()
            case .cycleRelatedSymptoms:
                CycleRelatedSymptomsScreen()
            case .healthAssistant:
                HealthAssistantScreen()
            case .sleepImpact:
                SleepImpactScreen()
            case .skinImpact:
                SkinImpactScreen()
            case .energyImpact:
                EnergyImpactScreen()
            // Part 3
            case .dietImpact:
                DietImpactScreen()
            case .mentalHealth:
                MentalHealthScreen()
            case .sexualWellness:
                SexualWellnessScreen()
            case .cycleSexEducation:
                CycleSexEducationScreen()
            case .cycleSexLife:
                CycleSexLifeScreen()
            case .bodyAwareness:
                BodyAwarenessScreen()
            case .sexDriveFluctuation:
                SexDriveFluctuationScreen()
            case .enhanceSexLife:
                EnhanceSexLifeScreen()
            case .pleasureInvolvement:
                PleasureInvolvementScreen()
            case .discoverPatterns:
                DiscoverPatternsScreen()
            case .thankYouHonesty:
                ThankYouHonestyScreen()
            case .heightInput:
                HeightInputScreen()
            case .weightInput:
                WeightInputScreen()
            case .healthIntegration:
                HealthIntegrationScreen()
            case .healthKitPermission:
                HealthKitPermissionScreen()
            case .personalizing:
                PersonalizingScreen()
            // Part 4
            case .valueComparison:
                ValueComparisonScreen()
            case .commitmentPledge:
                CommitmentPledgeScreen()
            case .welcomeSplash:
                WelcomeSplashScreen()
            case .paywall:
                PaywallScreen()
            case .premiumConfirmation:
                PremiumConfirmationScreen()
            }
        }
        .transition(
            .asymmetric(
                insertion: .move(edge: coordinator.navigationDirection == .forward ? .trailing : .leading)
                    .combined(with: .opacity),
                removal: .move(edge: coordinator.navigationDirection == .forward ? .leading : .trailing)
                    .combined(with: .opacity)
            )
        )
        .id(coordinator.currentStep)
    }
}
