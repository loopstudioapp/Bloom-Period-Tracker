import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        headerSection
                        periodCircleSection
                        dailyInsightsSection
                        duringPeriodSection
                        myCyclesSection
                        symptomPatternsSection
                    }
                }

                // Health Assistant Popup
                if viewModel.showHealthAssistantPopup {
                    AssistantPopupCard(
                        title: "Bloom Health Assistant",
                        message: viewModel.healthAssistantMessage,
                        ctaText: "Yes, let's talk",
                        onCTA: {
                            viewModel.dismissHealthAssistantPopup()
                            viewModel.showHealthChat = true
                        },
                        onDismiss: {
                            viewModel.dismissHealthAssistantPopup()
                        }
                    )
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.bottom, AppTheme.Spacing.sm)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.showHealthAssistantPopup)
                }
            }
            .background(AppTheme.Colors.background)
            .sheet(isPresented: $viewModel.showDailyLogging) {
                DailyLoggingSheet()
                    .presentationDetents([.large])
            }
            .fullScreenCover(isPresented: $viewModel.showCalendar) {
                FullCalendarScreen()
            }
            .fullScreenCover(isPresented: $viewModel.showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $viewModel.showHealthChat) {
                HealthAssistantChatView()
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        ZStack {
            AppTheme.Colors.todayHeaderGradient
                .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                TopNavBar(
                    month: viewModel.currentMonth,
                    notificationCount: viewModel.notificationCount,
                    onAvatarTap: { viewModel.showSettings = true },
                    onCalendarTap: { viewModel.showCalendar = true },
                    onNotificationTap: {}
                )

                WeekStripView(weekDays: viewModel.weekDays)
                    .padding(.vertical, AppTheme.Spacing.sm)
            }
        }
    }

    // MARK: - Period Circle Section
    private var periodCircleSection: some View {
        ZStack {
            // Background gradient
            AppTheme.Colors.todayHeaderGradient
                .frame(height: 200)
                .offset(y: -60)

            // Decorative circles
            decorativeCircles

            PeriodCircleView(
                periodDay: viewModel.periodDay,
                onLearnMoreTap: {},
                onEditDatesTap: { viewModel.showCalendar = true }
            )
            .padding(.top, -AppTheme.Spacing.md)
            .padding(.bottom, AppTheme.Spacing.xl)
        }
    }

    private var decorativeCircles: some View {
        ZStack {
            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.15))
                .frame(width: 30, height: 30)
                .offset(x: -120, y: -40)

            Circle()
                .fill(AppTheme.Colors.checkmarkBadgeBg.opacity(0.2))
                .frame(width: 20, height: 20)
                .offset(x: 130, y: -60)

            Circle()
                .fill(AppTheme.Colors.primaryPink.opacity(0.1))
                .frame(width: 40, height: 40)
                .offset(x: 100, y: 50)
        }
    }

    // MARK: - Daily Insights Section
    private var dailyInsightsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("My daily insights \u{00B7} Today")
                .font(AppTheme.Fonts.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(.horizontal, AppTheme.Spacing.lg)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(viewModel.dailyInsights) { insight in
                        InsightCard(insight: insight) {
                            if insight.type == .logSymptoms {
                                viewModel.showDailyLogging = true
                            }
                        }
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
        .padding(.bottom, AppTheme.Spacing.xl)
    }

    // MARK: - During Period Section
    private var duringPeriodSection: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Text("During your period")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(AppTheme.Spacing.md)
                .background(AppTheme.Colors.dayDetailSummaryBg)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))

            HStack(spacing: AppTheme.Spacing.sm) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppTheme.Colors.textSecondary)
                Text("Search articles, videos and more")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                Spacer()
            }
            .padding(AppTheme.Spacing.md)
            .background(AppTheme.Colors.searchBarBg)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium))
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
        .padding(.bottom, AppTheme.Spacing.xl)
    }

    // MARK: - My Cycles Section
    private var myCyclesSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("My cycles")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(.horizontal, AppTheme.Spacing.lg)

            CycleHistoryCard(
                currentCycle: viewModel.currentCycle,
                previousCycles: viewModel.previousCycles,
                onSeeAll: {},
                onLogPrevious: {}
            )
            .padding(.horizontal, AppTheme.Spacing.lg)

            CycleSummaryCard(
                metrics: viewModel.cycleSummaryMetrics,
                onLogPeriods: {}
            )
            .padding(.horizontal, AppTheme.Spacing.lg)
        }
        .padding(.bottom, AppTheme.Spacing.xl)
    }

    // MARK: - Symptom Patterns Section
    private var symptomPatternsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("My symptom patterns")
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Spacer()
                Button(action: {}) {
                    Text("See all")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.primaryPink)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)

            TabView {
                ForEach(viewModel.symptomPatterns) { pattern in
                    SymptomPatternCard(pattern: pattern)
                        .padding(.horizontal, AppTheme.Spacing.lg)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 380)

            if viewModel.symptomPatterns.count > 1 {
                Text("1 of \(viewModel.symptomPatterns.count)")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.bottom, AppTheme.Spacing.xxxl)
    }
}

#Preview {
    TodayView()
}
