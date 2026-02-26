import SwiftUI

// MARK: - Curved Bottom Shape
struct CurvedBottomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 60))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.maxY - 60),
            control: CGPoint(x: rect.midX, y: rect.maxY + 30)
        )
        path.closeSubpath()
        return path
    }
}

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    heroSection
                    dailyInsightsSection
                    selfCareSection
                    myCyclesSection
                    symptomPatternsSection
                }
                .constrainedWidth()
            }
            .background(AppTheme.Colors.background)
            .sheet(isPresented: $viewModel.showDailyLogging) {
                DailyLoggingSheet()
                    .presentationDetents([.large])
            }
            .fullScreenCover(isPresented: $viewModel.showCalendar) {
                FullCalendarScreen()
            }
        }
    }

    // MARK: - Hero Section (Header + Week Strip + Fertility Info)
    private var heroSection: some View {
        ZStack(alignment: .top) {
            // Curved gradient background — teal/sage when not on period, warm pink when on period
            Group {
                if viewModel.isOnPeriod {
                    AppTheme.Colors.todayHeroGradient
                } else {
                    AppTheme.Colors.todayHeroGradientCalm
                }
            }
            .clipShape(CurvedBottomShape())
            .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                TopNavBar(
                    month: viewModel.currentMonth,
                    onCalendarTap: { viewModel.showCalendar = true }
                )

                WeekStripView(weekDays: viewModel.weekDays)
                    .padding(.vertical, AppTheme.Spacing.sm)

                PeriodCircleView(
                    periodDay: viewModel.periodDay,
                    fertileDaysAway: viewModel.fertileDaysAway,
                    onLearnMoreTap: {},
                    onEditDatesTap: { viewModel.showCalendar = true },
                    onTemperatureTap: {}
                )
                .padding(.top, AppTheme.Spacing.sm)
                .padding(.bottom, AppTheme.Spacing.xxl)
            }
        }
        .frame(maxWidth: .infinity)
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
        .padding(.top, AppTheme.Spacing.sm)
        .padding(.bottom, AppTheme.Spacing.xl)
    }

    // MARK: - Self-care Section
    private var selfCareSection: some View {
        VStack(spacing: 0) {
            // Header
            Text("Self-care during your period")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppTheme.Spacing.lg)
                .padding(.vertical, AppTheme.Spacing.md)

            Divider()
                .background(AppTheme.Colors.selfCareDivider)
                .padding(.horizontal, AppTheme.Spacing.lg)

            // Self-care items
            HStack(spacing: 0) {
                ForEach(viewModel.selfCareItems) { item in
                    VStack(spacing: AppTheme.Spacing.sm) {
                        Image(systemName: item.icon)
                            .font(.system(size: 32))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .frame(height: 44)

                        Text(item.title)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.Spacing.md)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.selfCareBg)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
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

            if let currentCycle = viewModel.currentCycle {
                CycleHistoryCard(
                    currentCycle: currentCycle,
                    previousCycles: viewModel.previousCycles,
                    onSeeAll: {},
                    onLogPrevious: {}
                )
                .padding(.horizontal, AppTheme.Spacing.lg)
            }

            if !viewModel.cycleSummaryMetrics.isEmpty {
                CycleSummaryCard(
                    metrics: viewModel.cycleSummaryMetrics,
                    onLogPeriods: {}
                )
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
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
            .frame(height: AppTheme.ResponsiveLayout.symptomPatternHeight)

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
