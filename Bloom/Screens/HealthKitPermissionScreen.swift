import SwiftUI
import HealthKit

struct HealthKitPermissionScreen: View {
    @EnvironmentObject var coordinator: OnboardingCoordinator
    @EnvironmentObject var viewModel: OnboardingViewModel

    @State private var isRequesting = false

    private let healthStore = HKHealthStore()

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Spacer()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)

            Text("Connecting to Apple Health...")
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            requestHealthKitAuthorization()
        }
    }

    // MARK: - HealthKit Authorization

    private func requestHealthKitAuthorization() {
        guard !isRequesting else { return }
        isRequesting = true

        guard HKHealthStore.isHealthDataAvailable() else {
            viewModel.healthKitAuthorized = false
            coordinator.advance()
            return
        }

        let writeTypes: Set<HKSampleType> = [
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!,
            HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKQuantityType.quantityType(forIdentifier: .dietaryWater)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        ]

        let readTypes: Set<HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        ]

        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, _ in
            DispatchQueue.main.async {
                viewModel.healthKitAuthorized = success
                coordinator.advance()
            }
        }
    }
}

#Preview {
    HealthKitPermissionScreen()
        .environmentObject(OnboardingCoordinator())
        .environmentObject(OnboardingViewModel())
}
