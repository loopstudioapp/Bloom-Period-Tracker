import SwiftUI

struct GraphsOfEventsView: View {
    private let eventGroups: [(name: String, icon: String, color: Color)] = [
        ("Symptoms", "heart.text.square.fill", AppTheme.Colors.primaryPink),
        ("Steps", "figure.walk", AppTheme.Colors.tealAccent),
        ("Weight", "scalemass.fill", AppTheme.Colors.blueAccent),
        ("Vaginal Discharge", "drop.halffull", AppTheme.Colors.dischargePurple),
        ("Mood", "face.smiling.fill", AppTheme.Colors.orangeAccent),
        ("Water", "drop.fill", AppTheme.Colors.waterIconColor)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Subtitle
            Text("Please select the event group you would like to analyze.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)
                .padding(.vertical, AppTheme.Spacing.md)

            // Event list
            VStack(spacing: 0) {
                ForEach(Array(eventGroups.enumerated()), id: \.offset) { _, group in
                    if group.name == "Weight" {
                        NavigationLink(destination: WeightGraphView()) {
                            eventRow(title: group.name)
                        }
                        .buttonStyle(.plain)
                    } else {
                        NavigationLink(destination: EventGraphPlaceholderView(
                            eventName: group.name,
                            icon: group.icon,
                            iconColor: group.color
                        )) {
                            eventRow(title: group.name)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            Spacer()
        }
        .navigationTitle("Graphs of events")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func eventRow(title: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppTheme.Colors.textTertiary)
            }
            .padding(.vertical, AppTheme.Spacing.md)

            Divider()
                .background(AppTheme.Colors.divider)
        }
    }
}

#Preview {
    NavigationStack {
        GraphsOfEventsView()
    }
}
