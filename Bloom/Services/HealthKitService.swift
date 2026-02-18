import HealthKit
import SwiftUI

@MainActor
class HealthKitService: ObservableObject {
    @Published var isAuthorized: Bool = false
    private let healthStore = HKHealthStore()

    var isHealthDataAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    func requestAuthorization() async {
        guard isHealthDataAvailable else { return }

        let writeTypes: Set<HKSampleType> = [
            HKQuantityType(.basalBodyTemperature),
            HKCategoryType(.sleepAnalysis),
            HKQuantityType(.dietaryWater),
            HKQuantityType(.bodyMass)
        ]

        let readTypes: Set<HKObjectType> = [
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.basalBodyTemperature),
            HKQuantityType(.bodyMass)
        ]

        do {
            try await healthStore.requestAuthorization(toShare: writeTypes, read: readTypes)
            isAuthorized = true
        } catch {
            isAuthorized = false
        }
    }
}
