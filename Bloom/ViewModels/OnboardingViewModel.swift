import SwiftUI

@MainActor
class OnboardingViewModel: ObservableObject {
    // MARK: - Part 1 Simple Values
    @AppStorage("userName") var userName: String = ""
    @AppStorage("birthYear") var birthYear: Int = 2000
    @AppStorage("trackingForRaw") var trackingForRaw: String = ""
    @AppStorage("pregnancyStatusRaw") var pregnancyStatusRaw: String = ""
    @AppStorage("referralSourceRaw") var referralSourceRaw: String = ""
    @AppStorage("trackingPermissionGranted") var trackingPermissionGranted: Bool = false
    @AppStorage("periodFeelingRaw") var periodFeelingRaw: String = ""

    // MARK: - Privacy Consents
    @AppStorage("healthDataConsent") var healthDataConsent: Bool = false
    @AppStorage("privacyPolicyConsent") var privacyPolicyConsent: Bool = false
    @AppStorage("marketingConsent") var marketingConsent: Bool = false

    // MARK: - Part 1 Multi-select (JSON encoded)
    @AppStorage("selectedGoalsJSON") var selectedGoalsJSON: String = "[]"
    @AppStorage("selectedHelpPrefsJSON") var selectedHelpPrefsJSON: String = "[]"

    // MARK: - Part 3 Simple Values
    @AppStorage("dietImpactRaw") var dietImpactRaw: String = ""
    @AppStorage("cycleSexKnowledgeRaw") var cycleSexKnowledgeRaw: String = ""
    @AppStorage("bodyBestTimeRaw") var bodyBestTimeRaw: String = ""
    @AppStorage("sexDriveFluctuatesRaw") var sexDriveFluctuatesRaw: String = ""
    @AppStorage("pleasureInvolvementRaw") var pleasureInvolvementRaw: String = ""
    @AppStorage("heightFeet") var heightFeet: Int = 5
    @AppStorage("heightInches") var heightInches: Int = 2
    @AppStorage("weightPounds") var weightPounds: Int = 132
    @AppStorage("weightDecimal") var weightDecimal: Int = 2
    @AppStorage("wantsPartnerInvite") var wantsPartnerInvite: Bool = false
    @AppStorage("healthKitAuthorized") var healthKitAuthorized: Bool = false

    // MARK: - Part 3 Multi-select (JSON encoded)
    @AppStorage("mentalHealthSelectionsJSON") var mentalHealthSelectionsJSON: String = "[]"
    @AppStorage("sexualWellnessSelectionsJSON") var sexualWellnessSelectionsJSON: String = "[]"
    @AppStorage("enhanceSexLifeSelectionsJSON") var enhanceSexLifeSelectionsJSON: String = "[]"

    // MARK: - Part 2 Simple Values
    @AppStorage("periodRegularityRaw") var periodRegularityRaw: String = ""
    @AppStorage("birthControlMethodRaw") var birthControlMethodRaw: String = ""
    @AppStorage("notificationPermissionGranted") var notificationPermissionGranted: Bool = false
    @AppStorage("dischargeAwarenessRaw") var dischargeAwarenessRaw: String = ""
    @AppStorage("sleepImpactRaw") var sleepImpactRaw: String = ""
    @AppStorage("skinImpactRaw") var skinImpactRaw: String = ""
    @AppStorage("energyImpactRaw") var energyImpactRaw: String = ""

    // MARK: - Part 2: Period Date Ranges (ISO8601 strings)
    @AppStorage("recentPeriodStartDate") var recentPeriodStartDateString: String = ""
    @AppStorage("recentPeriodEndDate") var recentPeriodEndDateString: String = ""
    @AppStorage("previousPeriodStartDate") var previousPeriodStartDateString: String = ""
    @AppStorage("previousPeriodEndDate") var previousPeriodEndDateString: String = ""

    // MARK: - Part 2 Multi-select (JSON encoded)
    @AppStorage("selectedPeriodDatesJSON") var selectedPeriodDatesJSON: String = "[]"
    @AppStorage("healthConditionsJSON") var healthConditionsJSON: String = "[]"
    @AppStorage("todaySymptomsJSON") var todaySymptomsJSON: String = "[]"
    @AppStorage("cycleRelatedSymptomsJSON") var cycleRelatedSymptomsJSON: String = "[]"

    // MARK: - Part 1 Computed Properties
    var displayName: String {
        userName.isEmpty ? "there" : userName
    }

    var trackingFor: TrackingFor? {
        TrackingFor(rawValue: trackingForRaw)
    }

    var pregnancyStatus: PregnancyStatus? {
        PregnancyStatus(rawValue: pregnancyStatusRaw)
    }

    var referralSource: ReferralSource? {
        ReferralSource(rawValue: referralSourceRaw)
    }

    var periodFeeling: PeriodFeeling? {
        PeriodFeeling(rawValue: periodFeelingRaw)
    }

    // MARK: - Part 1 Tracking Goals (Multi-select)
    var selectedGoals: Set<TrackingGoal> {
        get {
            guard let data = selectedGoalsJSON.data(using: .utf8),
                  let rawValues = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(rawValues.compactMap { TrackingGoal(rawValue: $0) })
        }
        set {
            let rawValues = newValue.map { $0.rawValue }
            if let data = try? JSONEncoder().encode(rawValues),
               let json = String(data: data, encoding: .utf8) {
                selectedGoalsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleGoal(_ goal: TrackingGoal) {
        var goals = selectedGoals
        if goals.contains(goal) {
            goals.remove(goal)
        } else {
            goals.insert(goal)
        }
        selectedGoals = goals
    }

    func isGoalSelected(_ goal: TrackingGoal) -> Bool {
        selectedGoals.contains(goal)
    }

    // MARK: - Part 1 Help Preferences (Multi-select)
    var selectedHelpPreferences: Set<HelpPreference> {
        get {
            guard let data = selectedHelpPrefsJSON.data(using: .utf8),
                  let rawValues = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(rawValues.compactMap { HelpPreference(rawValue: $0) })
        }
        set {
            let rawValues = newValue.map { $0.rawValue }
            if let data = try? JSONEncoder().encode(rawValues),
               let json = String(data: data, encoding: .utf8) {
                selectedHelpPrefsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleHelpPreference(_ pref: HelpPreference) {
        var prefs = selectedHelpPreferences
        if prefs.contains(pref) {
            prefs.remove(pref)
        } else {
            prefs.insert(pref)
        }
        selectedHelpPreferences = prefs
    }

    func isHelpPreferenceSelected(_ pref: HelpPreference) -> Bool {
        selectedHelpPreferences.contains(pref)
    }

    // MARK: - Part 1 Period Feeling
    func selectPeriodFeeling(_ feeling: PeriodFeeling) {
        periodFeelingRaw = feeling.rawValue
        objectWillChange.send()
    }

    func isPeriodFeelingSelected(_ feeling: PeriodFeeling) -> Bool {
        periodFeelingRaw == feeling.rawValue
    }

    // MARK: - Part 1 Confirmation Summary
    var confirmationSummary: [String] {
        var items: [String] = []
        for pref in selectedHelpPreferences {
            items.append(pref.rawValue)
        }
        if items.isEmpty {
            for goal in selectedGoals {
                items.append(goal.rawValue)
            }
        }
        return items
    }

    // MARK: - Part 2: Period Regularity
    var periodRegularity: String? {
        periodRegularityRaw.isEmpty ? nil : periodRegularityRaw
    }

    func selectPeriodRegularity(_ value: String) {
        periodRegularityRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 2: Period Dates (Multi-select)
    var selectedPeriodDates: Set<Int> {
        get {
            guard let data = selectedPeriodDatesJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([Int].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                selectedPeriodDatesJSON = json
            }
            objectWillChange.send()
        }
    }

    func togglePeriodDate(_ day: Int) {
        var dates = selectedPeriodDates
        if dates.contains(day) {
            dates.remove(day)
        } else {
            dates.insert(day)
        }
        selectedPeriodDates = dates
    }

    func isPeriodDateSelected(_ day: Int) -> Bool {
        selectedPeriodDates.contains(day)
    }

    // MARK: - Part 2: Period Date Ranges (Date-based)

    private static let dateFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f
    }()

    var recentPeriodStartDate: Date? {
        get { Self.dateFormatter.date(from: recentPeriodStartDateString) }
        set {
            recentPeriodStartDateString = newValue.map { Self.dateFormatter.string(from: $0) } ?? ""
            objectWillChange.send()
        }
    }

    var recentPeriodEndDate: Date? {
        get { Self.dateFormatter.date(from: recentPeriodEndDateString) }
        set {
            recentPeriodEndDateString = newValue.map { Self.dateFormatter.string(from: $0) } ?? ""
            objectWillChange.send()
        }
    }

    var previousPeriodStartDate: Date? {
        get { Self.dateFormatter.date(from: previousPeriodStartDateString) }
        set {
            previousPeriodStartDateString = newValue.map { Self.dateFormatter.string(from: $0) } ?? ""
            objectWillChange.send()
        }
    }

    var previousPeriodEndDate: Date? {
        get { Self.dateFormatter.date(from: previousPeriodEndDateString) }
        set {
            previousPeriodEndDateString = newValue.map { Self.dateFormatter.string(from: $0) } ?? ""
            objectWillChange.send()
        }
    }

    /// Predicts next period start date based on user-entered period dates.
    /// Uses cycle length between previous and recent period starts if both exist,
    /// otherwise defaults to 28 days from the recent period start.
    var predictedNextPeriodDate: Date? {
        guard let recentStart = recentPeriodStartDate else { return nil }
        let calendar = Calendar.current

        if let previousStart = previousPeriodStartDate {
            let cycleLength = calendar.dateComponents([.day], from: previousStart, to: recentStart).day ?? 28
            let adjustedCycle = max(cycleLength, 21) // sanity floor
            return calendar.date(byAdding: .day, value: adjustedCycle, to: recentStart)
        } else {
            return calendar.date(byAdding: .day, value: 28, to: recentStart)
        }
    }

    var predictedNextPeriodDateString: String {
        guard let date = predictedNextPeriodDate else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: date)
    }

    // MARK: - Part 2: Birth Control
    var birthControlMethod: String? {
        birthControlMethodRaw.isEmpty ? nil : birthControlMethodRaw
    }

    func selectBirthControl(_ method: String) {
        birthControlMethodRaw = method
        objectWillChange.send()
    }

    // MARK: - Part 2: Health Conditions (Multi-select)
    var healthConditions: Set<String> {
        get {
            guard let data = healthConditionsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                healthConditionsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleHealthCondition(_ condition: String) {
        var conditions = healthConditions
        if conditions.contains(condition) {
            conditions.remove(condition)
        } else {
            conditions.insert(condition)
        }
        healthConditions = conditions
    }

    func isHealthConditionSelected(_ condition: String) -> Bool {
        healthConditions.contains(condition)
    }

    // MARK: - Part 2: Discharge Awareness
    var dischargeAwareness: String? {
        dischargeAwarenessRaw.isEmpty ? nil : dischargeAwarenessRaw
    }

    func selectDischargeAwareness(_ value: String) {
        dischargeAwarenessRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 2: Today Symptoms (Multi-select)
    var todaySymptoms: Set<String> {
        get {
            guard let data = todaySymptomsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                todaySymptomsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleTodaySymptom(_ symptom: String) {
        var symptoms = todaySymptoms
        if symptom == "None of these" {
            symptoms = ["None of these"]
        } else {
            symptoms.remove("None of these")
            if symptoms.contains(symptom) {
                symptoms.remove(symptom)
            } else {
                symptoms.insert(symptom)
            }
        }
        todaySymptoms = symptoms
    }

    func isTodaySymptomSelected(_ symptom: String) -> Bool {
        todaySymptoms.contains(symptom)
    }

    // MARK: - Part 2: Cycle Related Symptoms (Multi-select)
    var cycleRelatedSymptoms: Set<String> {
        get {
            guard let data = cycleRelatedSymptomsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                cycleRelatedSymptomsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleCycleSymptom(_ symptom: String) {
        var symptoms = cycleRelatedSymptoms
        if symptoms.contains(symptom) {
            symptoms.remove(symptom)
        } else {
            symptoms.insert(symptom)
        }
        cycleRelatedSymptoms = symptoms
    }

    func isCycleSymptomSelected(_ symptom: String) -> Bool {
        cycleRelatedSymptoms.contains(symptom)
    }

    // MARK: - Part 2: Impact Questions (single-select)
    var sleepImpact: String? {
        sleepImpactRaw.isEmpty ? nil : sleepImpactRaw
    }

    func selectSleepImpact(_ value: String) {
        sleepImpactRaw = value
        objectWillChange.send()
    }

    var skinImpact: String? {
        skinImpactRaw.isEmpty ? nil : skinImpactRaw
    }

    func selectSkinImpact(_ value: String) {
        skinImpactRaw = value
        objectWillChange.send()
    }

    var energyImpact: String? {
        energyImpactRaw.isEmpty ? nil : energyImpactRaw
    }

    func selectEnergyImpact(_ value: String) {
        energyImpactRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 3: Diet Impact (single-select)
    var dietImpact: String? {
        dietImpactRaw.isEmpty ? nil : dietImpactRaw
    }

    func selectDietImpact(_ value: String) {
        dietImpactRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 3: Mental Health (multi-select)
    var mentalHealthSelections: Set<String> {
        get {
            guard let data = mentalHealthSelectionsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                mentalHealthSelectionsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleMentalHealth(_ item: String) {
        var items = mentalHealthSelections
        if items.contains(item) {
            items.remove(item)
        } else {
            items.insert(item)
        }
        mentalHealthSelections = items
    }

    func isMentalHealthSelected(_ item: String) -> Bool {
        mentalHealthSelections.contains(item)
    }

    // MARK: - Part 3: Sexual Wellness (multi-select)
    var sexualWellnessSelections: Set<String> {
        get {
            guard let data = sexualWellnessSelectionsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                sexualWellnessSelectionsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleSexualWellness(_ item: String) {
        var items = sexualWellnessSelections
        if items.contains(item) {
            items.remove(item)
        } else {
            items.insert(item)
        }
        sexualWellnessSelections = items
    }

    func isSexualWellnessSelected(_ item: String) -> Bool {
        sexualWellnessSelections.contains(item)
    }

    // MARK: - Part 3: Cycle & Sex Knowledge (single-select, tap-to-advance)
    var cycleSexKnowledge: String? {
        cycleSexKnowledgeRaw.isEmpty ? nil : cycleSexKnowledgeRaw
    }

    func selectCycleSexKnowledge(_ value: String) {
        cycleSexKnowledgeRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 3: Body Awareness (single-select, tap-to-advance)
    var bodyBestTime: String? {
        bodyBestTimeRaw.isEmpty ? nil : bodyBestTimeRaw
    }

    func selectBodyBestTime(_ value: String) {
        bodyBestTimeRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 3: Sex Drive Fluctuation (single-select, tap-to-advance)
    var sexDriveFluctuates: String? {
        sexDriveFluctuatesRaw.isEmpty ? nil : sexDriveFluctuatesRaw
    }

    func selectSexDriveFluctuates(_ value: String) {
        sexDriveFluctuatesRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 3: Enhance Sex Life (multi-select)
    var enhanceSexLifeSelections: Set<String> {
        get {
            guard let data = enhanceSexLifeSelectionsJSON.data(using: .utf8),
                  let values = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return Set(values)
        }
        set {
            let values = Array(newValue)
            if let data = try? JSONEncoder().encode(values),
               let json = String(data: data, encoding: .utf8) {
                enhanceSexLifeSelectionsJSON = json
            }
            objectWillChange.send()
        }
    }

    func toggleEnhanceSexLife(_ item: String) {
        var items = enhanceSexLifeSelections
        if items.contains(item) {
            items.remove(item)
        } else {
            items.insert(item)
        }
        enhanceSexLifeSelections = items
    }

    func isEnhanceSexLifeSelected(_ item: String) -> Bool {
        enhanceSexLifeSelections.contains(item)
    }

    // MARK: - Part 3: Pleasure Involvement (single-select, tap-to-advance)
    var pleasureInvolvement: String? {
        pleasureInvolvementRaw.isEmpty ? nil : pleasureInvolvementRaw
    }

    func selectPleasureInvolvement(_ value: String) {
        pleasureInvolvementRaw = value
        objectWillChange.send()
    }

    // MARK: - Part 4: Subscription & Commitment
    @AppStorage("selectedPlanId") var selectedPlanId: String = "yearly"
    @AppStorage("trialEnabled") var trialEnabled: Bool = false
    @AppStorage("commitmentPledgeCompleted") var commitmentPledgeCompleted: Bool = false
    @AppStorage("isPremiumUser") var isPremiumUser: Bool = false

    func selectPlan(_ planId: String) {
        selectedPlanId = planId
        objectWillChange.send()
    }

    func completePledge() {
        commitmentPledgeCompleted = true
        objectWillChange.send()
    }

    func activatePremium() {
        isPremiumUser = true
        objectWillChange.send()
    }
}
