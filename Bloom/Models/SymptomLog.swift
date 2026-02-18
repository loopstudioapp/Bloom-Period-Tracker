import SwiftUI

struct SymptomCategory: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String?
    let symptoms: [SymptomItem]
}

struct SymptomItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: SymptomItem, rhs: SymptomItem) -> Bool {
        lhs.name == rhs.name
    }
}

struct Feeling: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
}

struct SexActivityOption: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct MainAppData {
    static let feelings: [Feeling] = [
        Feeling(name: "Calm", emoji: "😌"),
        Feeling(name: "Fatigue", emoji: "🔋"),
        Feeling(name: "Cramps", emoji: "🎯"),
        Feeling(name: "Acne", emoji: "🔘")
    ]

    static let sexActivities: [SexActivityOption] = [
        SexActivityOption(name: "Didn't have sex", icon: "💔"),
        SexActivityOption(name: "Protected sex", icon: "🛡️"),
        SexActivityOption(name: "Unprotected sex", icon: "💎"),
        SexActivityOption(name: "Oral sex", icon: "⛔"),
        SexActivityOption(name: "Anal sex", icon: "🍷"),
        SexActivityOption(name: "Masturbation", icon: "💕"),
        SexActivityOption(name: "Sensual touch", icon: "💖"),
        SexActivityOption(name: "Sex toys", icon: "💫")
    ]

    static let flowOptions: [MenstrualFlow] = MenstrualFlow.allCases
}
