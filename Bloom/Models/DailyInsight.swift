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
}

enum InsightType {
    case logSymptoms
    case article
    case symptomInfo
    case question
}

struct MainInsightData {
    static let todayInsights: [DailyInsight] = [
        DailyInsight(type: .logSymptoms, title: "Log your symptoms", subtitle: "Track how you feel today", iconName: "plus.circle.fill", backgroundColor: AppTheme.Colors.featurePeach, borderColor: nil, hasActionButton: true),
        DailyInsight(type: .article, title: "Non-penetrative sex ideas", subtitle: nil, iconName: "heart.fill", backgroundColor: AppTheme.Colors.insightCardBg, borderColor: AppTheme.Colors.insightCardBorder, hasActionButton: false),
        DailyInsight(type: .symptomInfo, title: "TENDER BREASTS", subtitle: "Why do they hurt?", iconName: "figure.stand", backgroundColor: AppTheme.Colors.insightCardBg, borderColor: AppTheme.Colors.insightCardBorder, hasActionButton: false),
        DailyInsight(type: .article, title: "Coping w/ pregnancy paranoia", subtitle: nil, iconName: "brain.head.profile", backgroundColor: AppTheme.Colors.featureLightBlue, borderColor: nil, hasActionButton: false)
    ]
}
