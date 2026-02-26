import SwiftUI

struct DailyInsight: Identifiable {
    let id = UUID()
    let type: InsightType
    let title: String
    let subtitle: String?
    let iconName: String?
    let backgroundColor: Color
    let borderColor: Color?
    let hasActionButton: Bool
    var ctaText: String? = nil
}

enum InsightType {
    case logSymptoms
    case article
    case symptomInfo
    case question
}

struct MainInsightData {
    private static var currentMonthName: String {
        let f = DateFormatter()
        f.dateFormat = "MMMM"
        return f.string(from: Date())
    }

    static var todayInsights: [DailyInsight] {
        [
            DailyInsight(
                type: .logSymptoms,
                title: "Log your\nsymptoms",
                subtitle: nil,
                iconName: "plus.circle.fill",
                backgroundColor: AppTheme.Colors.insightCardBg,
                borderColor: nil,
                hasActionButton: true
            ),
            DailyInsight(
                type: .article,
                title: "Fertility\ncalculator",
                subtitle: nil,
                iconName: "heart.circle.fill",
                backgroundColor: AppTheme.Colors.insightPurpleBg,
                borderColor: nil,
                hasActionButton: false
            ),
            DailyInsight(
                type: .article,
                title: "Legs up\nAfter Sex",
                subtitle: nil,
                iconName: "figure.cooldown",
                backgroundColor: AppTheme.Colors.insightCoralBg,
                borderColor: nil,
                hasActionButton: false
            ),
            DailyInsight(
                type: .symptomInfo,
                title: "\(currentMonthName)\nSymptoms\nto expect",
                subtitle: nil,
                iconName: nil,
                backgroundColor: AppTheme.Colors.insightLavenderBg,
                borderColor: nil,
                hasActionButton: false,
                ctaText: "Find out more"
            )
        ]
    }
}
