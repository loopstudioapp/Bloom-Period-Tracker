import SwiftUI

struct WeekStripView: View {
    let weekDays: [WeekDay]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.md) {
                ForEach(weekDays) { day in
                    VStack(spacing: AppTheme.Spacing.xs) {
                        Text(day.dayLetter)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textSecondary)

                        if day.isToday {
                            VStack(spacing: AppTheme.Spacing.xxs) {
                                Text("TODAY")
                                    .font(.system(size: 8, weight: .bold, design: .rounded))
                                    .foregroundColor(AppTheme.Colors.textSecondary)

                                Text("\(day.dayNumber)")
                                    .font(AppTheme.Fonts.bodyBold)
                                    .foregroundColor(AppTheme.Colors.textWhite)
                                    .frame(width: 36, height: 36)
                                    .background(AppTheme.Colors.todayBadgeBg)
                                    .clipShape(Circle())
                            }
                        } else if day.isPeriod {
                            Text("\(day.dayNumber)")
                                .font(AppTheme.Fonts.bodyBold)
                                .foregroundColor(AppTheme.Colors.textWhite)
                                .frame(width: 36, height: 36)
                                .background(AppTheme.Colors.periodDayNumbers)
                                .clipShape(Circle())
                        } else {
                            Text("\(day.dayNumber)")
                                .font(AppTheme.Fonts.body)
                                .foregroundColor(AppTheme.Colors.periodDayNormal)
                                .frame(width: 36, height: 36)
                        }
                    }
                }
            }
            .padding(.horizontal, AppTheme.Spacing.lg)
        }
    }
}
