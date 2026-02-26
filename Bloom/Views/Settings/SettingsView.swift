import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.md) {
                    // Profile card
                    ProfileCard(
                        email: viewModel.userEmail,
                        isPremium: viewModel.isPremium,
                        onEditTap: {}
                    )

                    // Goal selector
                    goalSection

                    // Menu items
                    menuItems

                }
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.top, AppTheme.Spacing.sm)
                .padding(.bottom, AppTheme.Spacing.xxl)
                .constrainedWidth()
            }
            .background(AppTheme.Colors.backgroundLight)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.showReminders) {
                RemindersView()
            }
            .navigationDestination(isPresented: $viewModel.showAnalysisMenu) {
                AnalysisMenuView()
            }
            .navigationDestination(isPresented: $viewModel.showReportPreview) {
                ReportPreviewView()
            }
            .navigationDestination(isPresented: $viewModel.showAppSettings) {
                AppSettingsView()
            }
        }
    }

    // MARK: - Goal Section

    private var goalSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("My goal:")
                .font(AppTheme.Fonts.subheadlineBold)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.horizontal, AppTheme.Spacing.xs)

            GoalPillSelector(
                goals: viewModel.goals,
                selectedGoal: viewModel.selectedGoal,
                onSelect: { viewModel.selectedGoal = $0 }
            )
        }
    }

    // MARK: - Menu Items

    private var menuItems: some View {
        VStack(spacing: 0) {
            AnalysisMenuItem(
                icon: "doc.on.clipboard",
                iconColor: AppTheme.Colors.tealAccent,
                title: "Report for a doctor",
                onTap: { viewModel.showReportPreview = true }
            )

            AnalysisMenuItem(
                icon: "chart.bar.xaxis",
                iconColor: AppTheme.Colors.tealAccent,
                title: "Graphs & reports",
                onTap: { viewModel.showAnalysisMenu = true }
            )

            AnalysisMenuItem(
                icon: "bell",
                iconColor: AppTheme.Colors.tealAccent,
                title: "Reminders",
                onTap: { viewModel.showReminders = true }
            )

            AnalysisMenuItem(
                icon: "gearshape",
                iconColor: AppTheme.Colors.tealAccent,
                title: "App settings",
                onTap: { viewModel.showAppSettings = true }
            )
        }
        .padding(.horizontal, AppTheme.Spacing.xs)
    }
}

#Preview {
    SettingsView()
}
