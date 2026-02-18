// /Users/infinity/Desktop/Period Tracker/Bloom/Components/SubscriptionPlanCard.swift
import SwiftUI

struct SubscriptionPlanCard: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppTheme.Spacing.md) {
                // Radio indicator
                Circle()
                    .stroke(isSelected ? AppTheme.Colors.paywallAccentPurple : AppTheme.Colors.paywallTextMuted, lineWidth: 2)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Circle()
                            .fill(isSelected ? AppTheme.Colors.paywallAccentPurple : Color.clear)
                            .frame(width: 12, height: 12)
                    )

                VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                    HStack {
                        Text(plan.title)
                            .font(AppTheme.Fonts.bodyBold)
                            .foregroundColor(AppTheme.Colors.textWhite)

                        if plan.isMostPopular {
                            Text("BEST VALUE")
                                .font(AppTheme.Fonts.captionBold)
                                .foregroundColor(AppTheme.Colors.textWhite)
                                .padding(.horizontal, AppTheme.Spacing.sm)
                                .padding(.vertical, AppTheme.Spacing.xxs)
                                .background(AppTheme.Colors.paywallBadgeGreen)
                                .clipShape(Capsule())
                        }

                        Spacer()
                    }

                    HStack(spacing: AppTheme.Spacing.sm) {
                        Text(plan.price)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundColor(AppTheme.Colors.paywallTextMuted)

                        if let savings = plan.savings {
                            Text(savings)
                                .font(AppTheme.Fonts.captionBold)
                                .foregroundColor(AppTheme.Colors.paywallGold)
                        }
                    }

                    if let trialText = plan.trialText {
                        Text(trialText)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.tealAccent)
                    }
                }
            }
            .padding(AppTheme.Spacing.md)
            .background(AppTheme.Colors.paywallCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large)
                    .stroke(isSelected ? AppTheme.Colors.paywallSelectedBorder : Color(AppTheme.Colors.paywallCardBackground), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
