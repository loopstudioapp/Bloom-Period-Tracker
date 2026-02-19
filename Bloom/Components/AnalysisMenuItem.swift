import SwiftUI

struct AnalysisMenuItem: View {
    let icon: String
    let iconColor: Color
    let title: String
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                HStack(spacing: AppTheme.Spacing.md) {
                    // Icon in colored circle
                    ZStack {
                        Circle()
                            .fill(iconColor.opacity(0.15))
                            .frame(width: AppTheme.ResponsiveLayout.scaled(40), height: AppTheme.ResponsiveLayout.scaled(40))

                        Image(systemName: icon)
                            .font(.system(size: 18))
                            .foregroundColor(iconColor)
                    }

                    // Title
                    Text(title)
                        .font(AppTheme.Fonts.body)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    Spacer()

                    // Chevron
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppTheme.Colors.textTertiary)
                }
                .padding(.vertical, AppTheme.Spacing.md)

                // Bottom divider
                Divider()
                    .background(AppTheme.Colors.divider)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 0) {
        AnalysisMenuItem(
            icon: "chart.bar.fill",
            iconColor: AppTheme.Colors.primaryPink,
            title: "Cycle Length"
        )

        AnalysisMenuItem(
            icon: "waveform.path.ecg",
            iconColor: AppTheme.Colors.tealAccent,
            title: "Symptom Patterns"
        )

        AnalysisMenuItem(
            icon: "scalemass.fill",
            iconColor: AppTheme.Colors.blueAccent,
            title: "Weight Trends"
        )
    }
    .padding(.horizontal, AppTheme.Spacing.md)
}
