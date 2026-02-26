import SwiftUI

struct WeightGraphView: View {
    @StateObject private var viewModel = AnalyticsViewModel()

    private let cycle = CycleService.shared

    @State private var cycleOffset: Int = 0

    private var cycleStartDate: Date {
        let base = cycle.currentCycleStartDate ?? Date()
        return Calendar.current.date(byAdding: .day, value: cycleOffset * cycle.cycleLength, to: base) ?? base
    }

    private var cycleEndDate: Date {
        Calendar.current.date(byAdding: .day, value: cycle.cycleLength, to: cycleStartDate) ?? cycleStartDate
    }

    private var periodStart: Date { cycleStartDate }
    private var fertileWindow: (start: Date, end: Date) {
        cycle.fertileWindow(from: cycleStartDate)
    }
    private var ovulationDate: Date {
        cycle.predictedOvulation(from: cycleStartDate)
    }

    private var weightChartPoints: [WeightChartDataPoint] {
        // No weight persistence layer yet — return empty
        []
    }

    private var cycleDateLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let start = formatter.string(from: cycleStartDate)
        let end = formatter.string(from: cycleEndDate)
        return "\(start) — \(end)"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.lg) {
                // Chosen cycle label
                Text("Chosen cycle")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, AppTheme.Spacing.sm)

                // Cycle selector
                HStack {
                    Button {
                        cycleOffset -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }

                    Spacer()

                    Text(cycleDateLabel)
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    Button {
                        cycleOffset += 1
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.xl)

                // Changes during the cycle
                HStack {
                    Text("Changes during the cycle")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Spacer()

                    Text("0 lbs.")
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .padding(.horizontal, AppTheme.Spacing.md)

                // Weight chart
                WeightChart(
                    dataPoints: weightChartPoints,
                    periodStart: periodStart,
                    fertileStart: fertileWindow.start,
                    fertileEnd: fertileWindow.end,
                    ovulationDate: ovulationDate
                )
                .padding(.horizontal, AppTheme.Spacing.sm)

                Spacer()
            }
        }
        .navigationTitle("Weight")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Settings action
                } label: {
                    Text("Settings")
                        .font(AppTheme.Fonts.subheadline)
                        .foregroundColor(AppTheme.Colors.addLogFAB)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WeightGraphView()
    }
}
