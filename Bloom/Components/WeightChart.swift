import SwiftUI

struct WeightChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
}

struct WeightChart: View {
    let dataPoints: [WeightChartDataPoint]
    let periodStart: Date
    let fertileStart: Date
    let fertileEnd: Date
    let ovulationDate: Date

    @State private var appeared = false

    private var dotSize: CGFloat { AppTheme.ResponsiveLayout.scaled(8) }
    private var chartHeight: CGFloat { AppTheme.ResponsiveLayout.scaled(200) }
    private var phaseBarHeight: CGFloat { AppTheme.ResponsiveLayout.scaled(24) }
    private var yAxisWidth: CGFloat { AppTheme.ResponsiveLayout.scaled(44) }

    private var weightRange: (min: Double, max: Double) {
        guard !dataPoints.isEmpty else { return (120, 140) }
        let weights = dataPoints.map(\.weight)
        let minW = (weights.min() ?? 120)
        let maxW = (weights.max() ?? 140)
        let padding = max((maxW - minW) * 0.15, 1.0)
        return (minW - padding, maxW + padding)
    }

    private var dateRange: (min: Date, max: Date) {
        guard !dataPoints.isEmpty else { return (Date(), Date()) }
        let dates = dataPoints.map(\.date).sorted()
        return (dates.first!, dates.last!)
    }

    private var yLabels: [Double] {
        let range = weightRange
        let step = max((range.max - range.min) / 4, 0.5)
        var labels: [Double] = []
        var current = range.min
        while current <= range.max {
            labels.append(current)
            current += step
        }
        return labels
    }

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xs) {
            // Chart area
            HStack(alignment: .top, spacing: 0) {
                // Y-axis labels
                VStack(spacing: 0) {
                    ForEach(yLabels.reversed(), id: \.self) { label in
                        Text(String(format: "%.0f", label))
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .frame(height: chartHeight / CGFloat(max(yLabels.count - 1, 1)))
                    }
                }
                .frame(width: yAxisWidth)

                // Chart canvas
                GeometryReader { geo in
                    let plotWidth = geo.size.width
                    let plotHeight = geo.size.height

                    ZStack {
                        // Horizontal grid lines
                        ForEach(yLabels, id: \.self) { label in
                            let yFraction = yFraction(for: label)
                            let y = plotHeight * (1 - yFraction)

                            Path { path in
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: plotWidth, y: y))
                            }
                            .stroke(
                                AppTheme.Colors.divider,
                                style: StrokeStyle(lineWidth: 0.5, dash: [4, 3])
                            )
                        }

                        // Data points
                        ForEach(dataPoints) { point in
                            let x = xPosition(for: point.date, in: plotWidth)
                            let y = plotHeight * (1 - yFraction(for: point.weight))

                            Circle()
                                .fill(AppTheme.Colors.weightChartDot)
                                .frame(width: dotSize, height: dotSize)
                                .position(x: x, y: y)
                                .scaleEffect(appeared ? 1.0 : 0.8)
                                .opacity(appeared ? 1.0 : 0)
                        }
                    }
                }
                .frame(height: chartHeight)
            }

            // X-axis date labels
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: yAxisWidth)

                GeometryReader { geo in
                    let plotWidth = geo.size.width
                    let xDates = xAxisDates()

                    ZStack {
                        ForEach(xDates, id: \.self) { date in
                            let x = xPosition(for: date, in: plotWidth)
                            Text(shortDateLabel(date))
                                .font(AppTheme.Fonts.caption)
                                .foregroundColor(AppTheme.Colors.textSecondary)
                                .position(x: x, y: 10)
                        }
                    }
                }
                .frame(height: 20)
            }

            // Cycle phase bar
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: yAxisWidth)

                GeometryReader { geo in
                    let plotWidth = geo.size.width

                    ZStack(alignment: .leading) {
                        // Period bar
                        let periodStartX = xPosition(for: periodStart, in: plotWidth)
                        let periodEndX = xPosition(
                            for: Calendar.current.date(byAdding: .day, value: 5, to: periodStart)!,
                            in: plotWidth
                        )

                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small / 2)
                            .fill(AppTheme.Colors.calendarPeriodCircle)
                            .frame(width: max(0, periodEndX - periodStartX), height: phaseBarHeight)
                            .offset(x: periodStartX)

                        // Fertile bar
                        let fertileStartX = xPosition(for: fertileStart, in: plotWidth)
                        let fertileEndX = xPosition(for: fertileEnd, in: plotWidth)

                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small / 2)
                            .fill(AppTheme.Colors.fertileBarGradient)
                            .frame(width: max(0, fertileEndX - fertileStartX), height: phaseBarHeight)
                            .offset(x: fertileStartX)

                        // Ovulation dot
                        let ovX = xPosition(for: ovulationDate, in: plotWidth)

                        Circle()
                            .fill(AppTheme.Colors.calendarFertileText)
                            .frame(width: 10, height: 10)
                            .position(x: ovX, y: phaseBarHeight / 2)
                    }
                }
                .frame(height: phaseBarHeight)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                appeared = true
            }
        }
    }

    // MARK: - Helpers

    private func yFraction(for weight: Double) -> CGFloat {
        let range = weightRange
        guard range.max > range.min else { return 0.5 }
        return CGFloat((weight - range.min) / (range.max - range.min))
    }

    private func xPosition(for date: Date, in width: CGFloat) -> CGFloat {
        let range = dateRange
        let totalInterval = range.max.timeIntervalSince(range.min)
        guard totalInterval > 0 else { return width / 2 }
        let fraction = date.timeIntervalSince(range.min) / totalInterval
        return CGFloat(fraction) * width
    }

    private func xAxisDates() -> [Date] {
        let range = dateRange
        let cal = Calendar.current
        let totalDays = cal.dateComponents([.day], from: range.min, to: range.max).day ?? 1
        let step = max(totalDays / 5, 1)
        var dates: [Date] = []
        var current = range.min
        while current <= range.max {
            dates.append(current)
            current = cal.date(byAdding: .day, value: step, to: current)!
        }
        return dates
    }

    private func shortDateLabel(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: date)
    }
}

#Preview {
    let cal = Calendar.current
    let today = Date()
    let points: [WeightChartDataPoint] = (0..<14).map { i in
        WeightChartDataPoint(
            date: cal.date(byAdding: .day, value: -13 + i, to: today)!,
            weight: Double.random(in: 130...135)
        )
    }

    WeightChart(
        dataPoints: points,
        periodStart: cal.date(byAdding: .day, value: -13, to: today)!,
        fertileStart: cal.date(byAdding: .day, value: -5, to: today)!,
        fertileEnd: cal.date(byAdding: .day, value: -1, to: today)!,
        ovulationDate: cal.date(byAdding: .day, value: -3, to: today)!
    )
    .padding(AppTheme.Spacing.md)
}
