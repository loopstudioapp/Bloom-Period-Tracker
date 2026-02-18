import SwiftUI

struct CycleDotStrip: View {
    let periodDays: Int
    let totalDays: Int
    var ovulationDay: Int = 14
    var fertileStart: Int = 11
    var fertileEnd: Int = 16

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<min(totalDays, 20), id: \.self) { day in
                Circle()
                    .fill(dotColor(for: day))
                    .frame(width: 6, height: 6)
            }
        }
    }

    private func dotColor(for day: Int) -> Color {
        if day < periodDays {
            return AppTheme.Colors.dotPeriod
        } else if day == ovulationDay {
            return AppTheme.Colors.dotOvulation
        } else if day >= fertileStart && day <= fertileEnd {
            return AppTheme.Colors.dotFertile
        } else {
            return AppTheme.Colors.dotNormal
        }
    }
}
