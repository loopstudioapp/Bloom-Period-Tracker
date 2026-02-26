import SwiftUI

struct BloomTabView: View {
    @State private var selectedTab: BloomTab = .today

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .tabItem {
                    Label(BloomTab.today.title, systemImage: BloomTab.today.icon)
                }
                .tag(BloomTab.today)

            InsightsView()
                .tabItem {
                    Label(BloomTab.insights.title, systemImage: BloomTab.insights.icon)
                }
                .tag(BloomTab.insights)

            BloomChatView()
                .tabItem {
                    Label(BloomTab.messages.title, systemImage: BloomTab.messages.icon)
                }
                .tag(BloomTab.messages)

            SettingsView()
                .tabItem {
                    Label(BloomTab.settings.title, systemImage: BloomTab.settings.icon)
                }
                .tag(BloomTab.settings)
        }
        .tint(AppTheme.Colors.tabBarActiveTint)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.shadowColor = UIColor(AppTheme.Colors.sectionDivider)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().unselectedItemTintColor = UIColor(AppTheme.Colors.tabBarInactiveTint)
        }
    }
}

enum BloomTab: Int, CaseIterable {
    case today, insights, messages, settings

    var title: String {
        switch self {
        case .today: return "Today"
        case .insights: return "Insights"
        case .messages: return "Bloom AI"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .today: return "calendar"
        case .insights: return "square.grid.2x2"
        case .messages: return "bubble.left"
        case .settings: return "gearshape"
        }
    }
}

#Preview {
    BloomTabView()
}
