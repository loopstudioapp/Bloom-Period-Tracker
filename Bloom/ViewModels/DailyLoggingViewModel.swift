import SwiftUI

@MainActor
class DailyLoggingViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var selectedFeelings: Set<String> = []
    @Published var selectedFlow: MenstrualFlow? = nil
    @Published var selectedSexActivities: Set<String> = []
    @Published var waterIntake: Int = 16
    @Published var waterGoal: Int = 72
    @Published var weight: Double = 132.1
    @Published var basalTemp: Double? = nil
    @Published var pills: [String] = []
    @Published var searchText: String = ""

    var cycleDay: Int { CycleService.shared.currentCycleDay }
    var dateTitle: String { "Today" }

    func toggleFeeling(_ name: String) {
        if selectedFeelings.contains(name) {
            selectedFeelings.remove(name)
        } else {
            selectedFeelings.insert(name)
        }
    }

    func isFeelingSelected(_ name: String) -> Bool {
        selectedFeelings.contains(name)
    }

    func selectFlow(_ flow: MenstrualFlow) {
        if selectedFlow == flow {
            selectedFlow = nil
        } else {
            selectedFlow = flow
        }
    }

    func toggleSexActivity(_ name: String) {
        if selectedSexActivities.contains(name) {
            selectedSexActivities.remove(name)
        } else {
            selectedSexActivities.insert(name)
        }
    }

    func isSexActivitySelected(_ name: String) -> Bool {
        selectedSexActivities.contains(name)
    }

    func addWater() { waterIntake += 8 }
    func removeWater() { waterIntake = max(0, waterIntake - 8) }

    func applyLog() {
        // Save to persistence
    }
}
