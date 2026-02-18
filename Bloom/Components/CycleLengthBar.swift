import SwiftUI

struct CycleLengthBar: View {
    let label: String
    let dateRange: String
    let periodDays: Int
    let totalDays: Int
    let isCurrent: Bool
    var averageDay: Int? = nil

    @State private var animatedProgress: CGFloat = 0

    private var periodFraction: CGFloat {
        guard totalDays > 0 else { return 0 }
        return CGFloat(periodDays) / CGFloat(totalDays)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            // Label
            if !label.isEmpty {
                Text(label.uppercased())
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Date range
            Text(dateRange)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textPrimary)

            // Bar + days label
            HStack(spacing: AppTheme.Spacing.sm) {
                GeometryReader { geo in
                    let totalWidth = geo.size.width

                    ZStack(alignment: .leading) {
                        // Full rest bar
                        Capsule()
                            .fill(AppTheme.Colors.cycleLengthBarRest)
                            .frame(height: 12)

                        // Period bar
                        if isCurrent {
                            // Faded extension for current cycle
                            Capsule()
                                .fill(AppTheme.Colors.cycleLengthBarPeriod.opacity(0.3))
                                .frame(width: max(12, totalWidth * periodFraction * animatedProgress * 1.3), height: 12)

                            Capsule()
                                .fill(AppTheme.Colors.cycleLengthBarPeriod)
                                .frame(width: max(12, totalWidth * periodFraction * animatedProgress), height: 12)
                        } else {
                            Capsule()
                                .fill(AppTheme.Colors.cycleLengthBarPeriod)
                                .frame(width: max(12, totalWidth * periodFraction * animatedProgress), height: 12)
                        }

                        // Average line
                        if let avg = averageDay, totalDays > 0 {
                            let avgFraction = CGFloat(avg) / CGFloat(totalDays)
                            let xPos = totalWidth * avgFraction

                            VStack(spacing: AppTheme.Spacing.xxs) {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 1, height: 0)

                                DashedVerticalLine()
                                    .stroke(
                                        AppTheme.Colors.averageLine,
                                        style: StrokeStyle(lineWidth: 1, dash: [3, 2])
                                    )
                                    .frame(width: 1, height: 28)

                                Text("AVERAGE")
                                    .font(Font.system(size: 8, weight: .semibold, design: .rounded))
                                    .foregroundColor(AppTheme.Colors.averageLine)
                            }
                            .offset(x: xPos - 0.5, y: -10)
                        }
                    }
                }
                .frame(height: 12)

                // Days count
                Text("\(totalDays) days")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.cycleLengthBarPeriod)
                    .fixedSize()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animatedProgress = 1.0
            }
        }
    }
}

// MARK: - Dashed Vertical Line Shape

private struct DashedVerticalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

#Preview {
    VStack(spacing: AppTheme.Spacing.xl) {
        CycleLengthBar(
            label: "Last Cycle",
            dateRange: "Jan 5 – Feb 2",
            periodDays: 5,
            totalDays: 29,
            isCurrent: false,
            averageDay: 28
        )

        CycleLengthBar(
            label: "Current Cycle",
            dateRange: "Feb 3 – Present",
            periodDays: 4,
            totalDays: 14,
            isCurrent: true
        )
    }
    .padding(AppTheme.Spacing.md)
}
