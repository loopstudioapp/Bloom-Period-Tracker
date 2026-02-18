import SwiftUI

struct AnalysisMenuView: View {
    @State private var showCycleLength = false
    @State private var showPeriodLength = false
    @State private var showPatterns = false
    @State private var showGraphsOfEvents = false
    @State private var showReportPreview = false

    var body: some View {
        VStack(spacing: 0) {
            // Menu items
            VStack(spacing: 0) {
                NavigationLink(destination: CycleLengthView()) {
                    AnalysisMenuItem(
                        icon: "moon.fill",
                        iconColor: AppTheme.Colors.graphIconCycle,
                        title: "Cycle length"
                    )
                }
                .buttonStyle(.plain)

                NavigationLink(destination: PeriodLengthView()) {
                    AnalysisMenuItem(
                        icon: "drop.fill",
                        iconColor: AppTheme.Colors.graphIconPeriod,
                        title: "Period length & intensity"
                    )
                }
                .buttonStyle(.plain)

                NavigationLink(destination: Text("Patterns of your body").navigationTitle("Patterns")) {
                    AnalysisMenuItem(
                        icon: "circle.dotted",
                        iconColor: AppTheme.Colors.graphIconPatterns,
                        title: "Patterns of your body"
                    )
                }
                .buttonStyle(.plain)

                NavigationLink(destination: GraphsOfEventsView()) {
                    AnalysisMenuItem(
                        icon: "chart.xyaxis.line",
                        iconColor: AppTheme.Colors.graphIconGraphs,
                        title: "Graphs of events"
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            Spacer()
                .frame(height: AppTheme.Spacing.xxl)

            // Report for a doctor button
            Button {
                showReportPreview = true
            } label: {
                Text("Report for a doctor")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .padding(.horizontal, AppTheme.Spacing.xl)
                    .padding(.vertical, AppTheme.Spacing.sm)
                    .background(
                        Capsule()
                            .fill(AppTheme.Colors.optionBackground)
                    )
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .sheet(isPresented: $showReportPreview) {
                NavigationStack {
                    ReportPreviewView()
                }
            }

            Spacer()
        }
        .navigationTitle("What would you like to analyze?")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AnalysisMenuView()
    }
}
