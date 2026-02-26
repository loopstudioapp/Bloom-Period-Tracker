import SwiftUI

struct EventGraphPlaceholderView: View {
    let eventName: String
    let icon: String
    let iconColor: Color

    private let cycle = CycleService.shared

    @State private var cycleOffset: Int = 0

    private var cycleStartDate: Date {
        let base = cycle.currentCycleStartDate ?? Date()
        return Calendar.current.date(byAdding: .day, value: cycleOffset * cycle.cycleLength, to: base) ?? base
    }

    private var cycleEndDate: Date {
        Calendar.current.date(byAdding: .day, value: cycle.cycleLength, to: cycleStartDate) ?? cycleStartDate
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

                // Empty state
                VStack(spacing: AppTheme.Spacing.lg) {
                    Spacer()
                        .frame(height: AppTheme.Spacing.xxl)

                    ZStack {
                        Circle()
                            .fill(iconColor.opacity(0.1))
                            .frame(width: 80, height: 80)

                        Image(systemName: icon)
                            .font(.system(size: 32))
                            .foregroundColor(iconColor)
                    }

                    VStack(spacing: AppTheme.Spacing.sm) {
                        Text("No \(eventName.lowercased()) data yet")
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textPrimary)

                        Text("Start logging \(eventName.lowercased()) daily to see patterns across your cycle here.")
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, AppTheme.Spacing.xl)
                    }

                    // Placeholder chart outline
                    VStack(spacing: 0) {
                        // Y-axis and chart area
                        HStack(alignment: .bottom, spacing: 4) {
                            // Y-axis labels
                            VStack {
                                Text("High")
                                    .font(.system(size: 10))
                                    .foregroundColor(AppTheme.Colors.textTertiary)
                                Spacer()
                                Text("Low")
                                    .font(.system(size: 10))
                                    .foregroundColor(AppTheme.Colors.textTertiary)
                            }
                            .frame(width: 30, height: 120)

                            // Chart bars placeholder
                            HStack(alignment: .bottom, spacing: 6) {
                                ForEach(0..<14, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(AppTheme.Colors.divider)
                                        .frame(height: 120)
                                }
                            }
                        }
                        .frame(height: 120)

                        // Phase legend
                        HStack(spacing: 0) {
                            phaseLegendSegment(label: "Period", color: AppTheme.Colors.primaryPink, flex: CGFloat(cycle.periodLength))
                            phaseLegendSegment(label: "Follicular", color: AppTheme.Colors.tealAccent, flex: CGFloat(max(cycle.ovulationDay - 4 - cycle.periodLength, 1)))
                            phaseLegendSegment(label: "Fertile", color: AppTheme.Colors.fertileGreen, flex: 6)
                            phaseLegendSegment(label: "Luteal", color: AppTheme.Colors.lutealYellow, flex: CGFloat(max(cycle.cycleLength - cycle.ovulationDay - 2, 1)))
                        }
                        .frame(height: 20)
                        .padding(.top, AppTheme.Spacing.xs)
                    }
                    .padding(AppTheme.Spacing.md)
                    .background(
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                            .fill(Color.white)
                    )
                    .cardShadow()

                    Spacer()
                        .frame(height: AppTheme.Spacing.xxl)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(AppTheme.Colors.backgroundLight)
        .navigationTitle(eventName)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func phaseLegendSegment(label: String, color: Color, flex: CGFloat) -> some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 2)
                .fill(color.opacity(0.3))
                .frame(width: geometry.size.width - 1, height: 16)
                .overlay(
                    Text(label)
                        .font(.system(size: 7))
                        .foregroundColor(color)
                        .lineLimit(1)
                )
        }
    }
}

#Preview {
    NavigationStack {
        EventGraphPlaceholderView(
            eventName: "Symptoms",
            icon: "heart.text.square.fill",
            iconColor: AppTheme.Colors.primaryPink
        )
    }
}
