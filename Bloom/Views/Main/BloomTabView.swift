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
                .badge("")

            SecretChatsView()
                .tabItem {
                    Label(BloomTab.secretChats.title, systemImage: BloomTab.secretChats.icon)
                }
                .tag(BloomTab.secretChats)
                .badge("")

            MessagesView()
                .tabItem {
                    Label(BloomTab.messages.title, systemImage: BloomTab.messages.icon)
                }
                .tag(BloomTab.messages)

            PartnerView()
                .tabItem {
                    Label(BloomTab.partner.title, systemImage: BloomTab.partner.icon)
                }
                .tag(BloomTab.partner)
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
    case today, insights, secretChats, messages, partner

    var title: String {
        switch self {
        case .today: return "Today"
        case .insights: return "Insights"
        case .secretChats: return "Secret Chats"
        case .messages: return "Messages"
        case .partner: return "Partner"
        }
    }

    var icon: String {
        switch self {
        case .today: return "calendar"
        case .insights: return "square.grid.2x2"
        case .secretChats: return "binoculars"
        case .messages: return "bubble.left"
        case .partner: return "person.2"
        }
    }
}

#Preview {
    BloomTabView()
}
