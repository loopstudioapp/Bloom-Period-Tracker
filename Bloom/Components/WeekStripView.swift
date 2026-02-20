import SwiftUI

struct WeekStripView: View {
    let weekDays: [WeekDay]

    var body: some View {
        HStack(spacing: 0) {
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
                                .frame(width: AppTheme.ResponsiveLayout.scaled(36), height: AppTheme.ResponsiveLayout.scaled(36))
                                .background(AppTheme.Colors.todayBadgeBg)
                                .clipShape(Circle())
                        }
                    } else if day.isPeriod {
                        Text("\(day.dayNumber)")
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textWhite)
                            .frame(width: AppTheme.ResponsiveLayout.scaled(36), height: AppTheme.ResponsiveLayout.scaled(36))
                            .background(AppTheme.Colors.periodDayNumbers)
                            .clipShape(Circle())
                    } else if day.isFertile {
                        Text("\(day.dayNumber)")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.predictedDayDash)
                            .frame(width: AppTheme.ResponsiveLayout.scaled(36), height: AppTheme.ResponsiveLayout.scaled(36))
                            .overlay(
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [4, 3]))
                                    .foregroundColor(AppTheme.Colors.predictedDayDash)
                            )
                    } else {
                        Text("\(day.dayNumber)")
                            .font(AppTheme.Fonts.body)
                            .foregroundColor(AppTheme.Colors.periodDayNormal)
                            .frame(width: AppTheme.ResponsiveLayout.scaled(36), height: AppTheme.ResponsiveLayout.scaled(36))
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }
}
