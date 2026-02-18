import SwiftUI

struct WeightGraphView: View {
    @StateObject private var viewModel = AnalyticsViewModel()

    @State private var cycleStartDate: Date = {
        let cal = Calendar.current
        var comps = DateComponents()
        comps.year = 2024
        comps.month = 1
        comps.day = 25
        return cal.date(from: comps) ?? Date()
    }()

    @State private var cycleEndDate: Date = {
        let cal = Calendar.current
        var comps = DateComponents()
        comps.year = 2024
        comps.month = 2
        comps.day = 22
        return cal.date(from: comps) ?? Date()
    }()

    private var cycleService: CycleService { CycleService.shared }

    private var periodStart: Date { cycleStartDate }
    private var fertileWindow: (start: Date, end: Date) {
        cycleService.fertileWindow(from: cycleStartDate)
    }
    private var ovulationDate: Date {
        cycleService.predictedOvulation(from: cycleStartDate)
    }

    private var weightChartPoints: [WeightChartDataPoint] {
        let cal = Calendar.current
        let totalDays = cal.dateComponents([.day], from: cycleStartDate, to: cycleEndDate).day ?? 28
        return (0..<totalDays).map { dayOffset in
            let date = cal.date(byAdding: .day, value: dayOffset, to: cycleStartDate)!
            let weight = 132.0 + Double.random(in: -2.0...2.0)
            return WeightChartDataPoint(date: date, weight: weight)
        }
    }

    private var cycleDateLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let start = formatter.string(from: cycleStartDate)

        let endFormatter = DateFormatter()
        endFormatter.dateFormat = "MMM d"
        let end = endFormatter.string(from: cycleEndDate)

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
                        // Navigate to previous cycle
                        let cal = Calendar.current
                        cycleStartDate = cal.date(byAdding: .day, value: -29, to: cycleStartDate) ?? cycleStartDate
                        cycleEndDate = cal.date(byAdding: .day, value: -29, to: cycleEndDate) ?? cycleEndDate
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
                        // Navigate to next cycle
                        let cal = Calendar.current
                        cycleStartDate = cal.date(byAdding: .day, value: 29, to: cycleStartDate) ?? cycleStartDate
                        cycleEndDate = cal.date(byAdding: .day, value: 29, to: cycleEndDate) ?? cycleEndDate
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
