import SwiftUI

struct PatternsView: View {
    private let cycle = CycleService.shared

    private var phases: [PhaseInfo] {
        let cl = cycle.cycleLength
        let pl = cycle.periodLength
        let ov = cycle.ovulationDay

        return [
            PhaseInfo(
                type: .period,
                name: "Menstrual",
                dayRange: "Days 1–\(pl)",
                duration: pl,
                color: AppTheme.Colors.primaryPink,
                icon: "drop.fill",
                description: "Your period. Energy may be lower. Focus on rest, iron-rich foods, and gentle movement.",
                symptoms: ["Cramps", "Fatigue", "Bloating", "Lower back pain"]
            ),
            PhaseInfo(
                type: .follicular,
                name: "Follicular",
                dayRange: "Days \(pl + 1)–\(ov - 4)",
                duration: max(ov - 4 - pl, 1),
                color: AppTheme.Colors.tealAccent,
                icon: "leaf.fill",
                description: "Estrogen rises. You may feel more energetic and creative. Great time for new projects and social activities.",
                symptoms: ["Rising energy", "Better mood", "Increased focus", "Glowing skin"]
            ),
            PhaseInfo(
                type: .fertile,
                name: "Fertile Window",
                dayRange: "Days \(ov - 3)–\(ov + 2)",
                duration: 6,
                color: AppTheme.Colors.fertileGreen,
                icon: "sparkles",
                description: "Peak fertility surrounds ovulation. Highest chance of conception. Cervical mucus changes.",
                symptoms: ["Increased libido", "Cervical mucus changes", "Mild pelvic pain", "Breast tenderness"]
            ),
            PhaseInfo(
                type: .ovulation,
                name: "Ovulation",
                dayRange: "Day \(ov)",
                duration: 1,
                color: AppTheme.Colors.ovulationPurple,
                icon: "circle.circle.fill",
                description: "Egg release. Peak estrogen and LH surge. Some feel a twinge of pain (mittelschmerz).",
                symptoms: ["Mittelschmerz", "Temperature rise", "LH surge", "Peak energy"]
            ),
            PhaseInfo(
                type: .luteal,
                name: "Luteal",
                dayRange: "Days \(ov + 3)–\(cl)",
                duration: max(cl - ov - 2, 1),
                color: AppTheme.Colors.lutealYellow,
                icon: "moon.fill",
                description: "Progesterone rises then falls. PMS symptoms may appear in the second half. Prioritize self-care.",
                symptoms: ["Mood changes", "Cravings", "Bloating", "Fatigue"]
            )
        ]
    }

    private var currentPhaseIndex: Int {
        let phase = cycle.currentPhase
        return phases.firstIndex(where: { $0.type == phase }) ?? 0
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.lg) {
                // Current cycle day header
                if cycle.hasData {
                    currentDayHeader()
                }

                // Cycle phase bar
                cyclePhaseBar()

                // Phase cards
                ForEach(Array(phases.enumerated()), id: \.offset) { index, phase in
                    phaseCard(phase: phase, isActive: index == currentPhaseIndex && cycle.hasData)
                }

                // Disclaimer
                HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.Colors.textTertiary)

                    Text("Cycle phases and symptoms vary between individuals. This is a general guide based on your tracked data. Consult your healthcare provider for personalized advice.")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textTertiary)
                        .lineSpacing(3)
                }
                .padding(AppTheme.Spacing.sm)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small)
                        .fill(AppTheme.Colors.optionBackground)
                )
            }
            .padding(.horizontal, AppTheme.Spacing.md)
            .padding(.vertical, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.backgroundLight)
        .navigationTitle("Patterns of your body")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Current Day Header

    @ViewBuilder
    private func currentDayHeader() -> some View {
        let phase = phases[currentPhaseIndex]

        VStack(spacing: AppTheme.Spacing.sm) {
            Text("Cycle Day \(cycle.currentCycleDay)")
                .font(AppTheme.Fonts.title2)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .fontWeight(.bold)

            HStack(spacing: AppTheme.Spacing.xs) {
                Image(systemName: phase.icon)
                    .font(.system(size: 14))
                    .foregroundColor(phase.color)

                Text(phase.name + " Phase")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(phase.color)
            }
            .padding(.horizontal, AppTheme.Spacing.md)
            .padding(.vertical, AppTheme.Spacing.xs)
            .background(
                Capsule()
                    .fill(phase.color.opacity(0.15))
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(Color.white)
        )
        .cardShadow()
    }

    // MARK: - Cycle Phase Bar

    @ViewBuilder
    private func cyclePhaseBar() -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("YOUR \(cycle.cycleLength)-DAY CYCLE")
                .font(AppTheme.Fonts.captionBold)
                .foregroundColor(AppTheme.Colors.textSecondary)

            GeometryReader { geometry in
                let totalWidth = geometry.size.width
                let totalDays = CGFloat(cycle.cycleLength)

                HStack(spacing: 1) {
                    ForEach(Array(phases.enumerated()), id: \.offset) { index, phase in
                        let proportion = CGFloat(phase.duration) / totalDays
                        let width = max(proportion * totalWidth - CGFloat(phases.count - 1), 4)

                        RoundedRectangle(cornerRadius: 3)
                            .fill(phase.color)
                            .frame(width: width, height: 24)
                            .overlay(
                                Group {
                                    if index == currentPhaseIndex && cycle.hasData {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(phase.color)
                                            .offset(y: -16)
                                    }
                                }
                            )
                    }
                }
            }
            .frame(height: 24)

            // Legend
            HStack(spacing: AppTheme.Spacing.md) {
                ForEach(Array(phases.enumerated()), id: \.offset) { _, phase in
                    HStack(spacing: 4) {
                        Circle()
                            .fill(phase.color)
                            .frame(width: 8, height: 8)

                        Text(phase.name)
                            .font(.system(size: 9))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(Color.white)
        )
        .cardShadow()
    }

    // MARK: - Phase Card

    @ViewBuilder
    private func phaseCard(phase: PhaseInfo, isActive: Bool) -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            HStack {
                HStack(spacing: AppTheme.Spacing.sm) {
                    ZStack {
                        Circle()
                            .fill(phase.color.opacity(0.15))
                            .frame(width: 36, height: 36)

                        Image(systemName: phase.icon)
                            .font(.system(size: 16))
                            .foregroundColor(phase.color)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(phase.name)
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textPrimary)

                        Text(phase.dayRange)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }

                Spacer()

                if isActive {
                    Text("NOW")
                        .font(AppTheme.Fonts.captionBold)
                        .foregroundColor(.white)
                        .padding(.horizontal, AppTheme.Spacing.sm)
                        .padding(.vertical, AppTheme.Spacing.xxs)
                        .background(
                            Capsule()
                                .fill(phase.color)
                        )
                }
            }

            Text(phase.description)
                .font(AppTheme.Fonts.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineSpacing(3)

            // Symptoms
            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text("COMMON SIGNS")
                    .font(AppTheme.Fonts.captionBold)
                    .foregroundColor(AppTheme.Colors.textTertiary)

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: AppTheme.Spacing.xs) {
                    ForEach(phase.symptoms, id: \.self) { symptom in
                        HStack(spacing: 6) {
                            Circle()
                                .fill(phase.color)
                                .frame(width: 6, height: 6)

                            Text(symptom)
                                .font(AppTheme.Fonts.caption)
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                        .stroke(isActive ? phase.color : Color.clear, lineWidth: 2)
                )
        )
        .cardShadow()
    }
}

// MARK: - Phase Info Model

private struct PhaseInfo {
    let type: CyclePhaseType
    let name: String
    let dayRange: String
    let duration: Int
    let color: Color
    let icon: String
    let description: String
    let symptoms: [String]
}

#Preview {
    NavigationStack {
        PatternsView()
    }
}
