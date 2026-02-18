import SwiftUI

struct GoalPillSelector: View {
    let goals: [String]
    let selectedGoal: String
    var onSelect: (String) -> Void = { _ in }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.sm) {
                ForEach(goals, id: \.self) { goal in
                    let isSelected = goal == selectedGoal

                    Button(action: {
                        onSelect(goal)
                    }) {
                        Text(goal)
                            .font(AppTheme.Fonts.subheadlineBold)
                            .foregroundColor(
                                isSelected
                                    ? AppTheme.Colors.textWhite
                                    : AppTheme.Colors.textPrimary
                            )
                            .padding(.horizontal, AppTheme.Spacing.md)
                            .padding(.vertical, AppTheme.Spacing.sm)
                            .background(
                                Capsule()
                                    .fill(
                                        isSelected
                                            ? AppTheme.Colors.goalPillSelectedBg
                                            : AppTheme.Colors.goalPillUnselectedBg
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)
        }
    }
}

#Preview {
    @Previewable @State var selected = "Track Period"

    GoalPillSelector(
        goals: ["Track Period", "Get Pregnant", "Avoid Pregnancy", "Health"],
        selectedGoal: selected,
        onSelect: { selected = $0 }
    )
}
