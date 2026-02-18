import SwiftUI

struct GraphsOfEventsView: View {
    private let eventGroups = [
        "Symptoms",
        "Steps",
        "Weight",
        "Vaginal Discharge",
        "Mood",
        "Water"
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
                ForEach(eventGroups, id: \.self) { group in
                    if group == "Weight" {
                        NavigationLink(destination: WeightGraphView()) {
                            eventRow(title: group)
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button {
                            // Placeholder action for other event groups
                        } label: {
                            eventRow(title: group)
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
