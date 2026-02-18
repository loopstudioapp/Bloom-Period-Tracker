import SwiftUI

struct CalendarMagnifyingGlassIllustration: View {
    private let illustrationSize: CGFloat = 200

    var body: some View {
        ZStack {
            // Spiral notebook
            notebook

            // Magnifying glass overlapping from bottom-left
            magnifyingGlass
                .offset(x: -glassOffsetX, y: glassOffsetY)
        }
        .frame(width: illustrationSize, height: illustrationSize)
    }

    // MARK: - Notebook

    private var notebook: some View {
        ZStack(alignment: .top) {
            // Notebook body
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                .fill(AppTheme.Colors.cardBackground)
                .frame(width: notebookWidth, height: notebookHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                        .stroke(AppTheme.Colors.lightBlueIllustration, lineWidth: 1)
                )

            VStack(spacing: .zero) {
                // Spiral rings at top
                spiralRings

                // Day headers
                dayHeaders
                    .padding(.top, AppTheme.Spacing.sm)

                // Grid lines
                gridLines
                    .padding(.top, AppTheme.Spacing.xs)
            }
            .frame(width: notebookWidth)
        }
    }

    // MARK: - Spiral Rings

    private var spiralRings: some View {
        HStack(spacing: spiralSpacing) {
            ForEach(0..<6, id: \.self) { _ in
                Capsule()
                    .fill(AppTheme.Colors.lightBlueIllustration)
                    .frame(width: spiralWidth, height: spiralHeight)
            }
        }
        .offset(y: -spiralHeight / 2)
    }

    // MARK: - Day Headers

    private var dayHeaders: some View {
        let days = ["S", "M", "T", "W", "T", "F", "S"]
        return HStack(spacing: .zero) {
            ForEach(days.indices, id: \.self) { index in
                Text(days[index])
                    .font(.system(size: dayHeaderFontSize, weight: .medium, design: .rounded))
                    .foregroundColor(AppTheme.Colors.navyDark)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.xs)
    }

    // MARK: - Grid Lines

    private var gridLines: some View {
        VStack(spacing: gridLineSpacing) {
            ForEach(0..<5, id: \.self) { _ in
                Rectangle()
                    .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.5))
                    .frame(height: 0.5)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.sm)
    }

    // MARK: - Magnifying Glass

    private var magnifyingGlass: some View {
        ZStack {
            // Handle
            Capsule()
                .fill(AppTheme.Colors.navyDark)
                .frame(width: handleWidth, height: handleHeight)
                .rotationEffect(.degrees(45))
                .offset(x: handleOffsetX, y: handleOffsetY)

            // Glass circle
            Circle()
                .stroke(AppTheme.Colors.navyDark, lineWidth: glassRimWidth)
                .frame(width: glassDiameter, height: glassDiameter)
                .background(
                    Circle()
                        .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.15))
                )
        }
    }

    // MARK: - Sizes

    private var notebookWidth: CGFloat { illustrationSize * 0.55 }
    private var notebookHeight: CGFloat { illustrationSize * 0.6 }
    private var spiralWidth: CGFloat { AppTheme.Spacing.sm }
    private var spiralHeight: CGFloat { AppTheme.Spacing.md }
    private var spiralSpacing: CGFloat { AppTheme.Spacing.sm + AppTheme.Spacing.xxs }
    private var dayHeaderFontSize: CGFloat { 7 }
    private var gridLineSpacing: CGFloat { AppTheme.Spacing.sm + AppTheme.Spacing.xxs }
    private var glassDiameter: CGFloat { illustrationSize * 0.35 }
    private var glassRimWidth: CGFloat { AppTheme.Spacing.xs + AppTheme.Spacing.xxs }
    private var handleWidth: CGFloat { AppTheme.Spacing.sm + AppTheme.Spacing.xxs }
    private var handleHeight: CGFloat { illustrationSize * 0.22 }
    private var handleOffsetX: CGFloat { glassDiameter * 0.35 }
    private var handleOffsetY: CGFloat { glassDiameter * 0.35 }
    private var glassOffsetX: CGFloat { AppTheme.Spacing.md }
    private var glassOffsetY: CGFloat { AppTheme.Spacing.xxl }
}

#Preview {
    CalendarMagnifyingGlassIllustration()
        .padding(AppTheme.Spacing.xxxl)
        .background(AppTheme.Colors.backgroundPink)
}
