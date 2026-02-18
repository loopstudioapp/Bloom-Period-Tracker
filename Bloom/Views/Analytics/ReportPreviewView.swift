import SwiftUI

struct ReportPreviewView: View {
    @Environment(\.dismiss) private var dismiss

    private let coverageStart = "December 26, 2023"
    private let coverageEnd = "February 22, 2024"
    private let exportedDate = "January 28, 2024"

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.xl) {
                    // Page 1
                    reportPage1()

                    // Page 2
                    reportPage2()
                }
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.vertical, AppTheme.Spacing.md)
            }

            // Send or print button
            Button {
                // Send or print action
            } label: {
                Text("Send or print")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.sendPrintText)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.backgroundLight)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Report preview")
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
                .accessibilityLabel("Close")
            }
        }
    }

    // MARK: - Page 1

    @ViewBuilder
    private func reportPage1() -> some View {
        HStack(spacing: 0) {
            // Left pink border
            Rectangle()
                .fill(AppTheme.Colors.reportBorderLeft)
                .frame(width: 4)

            // Content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                // Page badge
                Text("1 of 2")
                    .font(AppTheme.Fonts.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .padding(.horizontal, AppTheme.Spacing.sm)
                    .padding(.vertical, AppTheme.Spacing.xxs)
                    .background(
                        Capsule()
                            .fill(AppTheme.Colors.optionBackground)
                    )

                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                        Text("HEALTH REPORT")
                            .font(AppTheme.Fonts.title3)
                            .foregroundColor(AppTheme.Colors.reportHeaderText)
                            .fontWeight(.bold)

                        HStack(spacing: AppTheme.Spacing.xs) {
                            Text("Made by Bloom")
                                .font(AppTheme.Fonts.subheadline)
                                .foregroundColor(AppTheme.Colors.reportHeaderText)

                            Image(systemName: "leaf.fill")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.Colors.reportHeaderText)
                        }
                    }

                    Spacer()

                    Text("www.bloom.health")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.reportHeaderText)
                }

                // Coverage and export dates
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                    Text("COVERAGE: \(coverageStart) - \(coverageEnd)")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    Text("EXPORTED: \(exportedDate)")
                        .font(AppTheme.Fonts.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                // Description
                Text("This report contains a summary of your cycle data tracked in Bloom. It is designed to help you share relevant health information with your doctor or healthcare provider.")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineSpacing(4)

                Divider()
                    .background(AppTheme.Colors.divider)

                // Cycle and period length section
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    Text("Cycle and period length")
                        .font(AppTheme.Fonts.bodyBold)
                        .foregroundColor(AppTheme.Colors.textPrimary)

                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                        Text("AVERAGE CYCLE LENGTH: 29 days")
                            .font(AppTheme.Fonts.captionBold)
                            .foregroundColor(AppTheme.Colors.textSecondary)

                        Text("AVERAGE PERIOD LENGTH: 5 days")
                            .font(AppTheme.Fonts.captionBold)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }

                    // Cycle bars
                    CycleLengthBar(
                        label: "CURRENT CYCLE",
                        dateRange: "Jan 25 - Feb 22",
                        periodDays: 4,
                        totalDays: 29,
                        isCurrent: true,
                        averageDay: 29
                    )

                    CycleLengthBar(
                        label: "",
                        dateRange: "Dec 26, 2023 - Jan 24, 2024",
                        periodDays: 5,
                        totalDays: 30,
                        isCurrent: false,
                        averageDay: 29
                    )
                }
            }
            .padding(AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.reportCardBg)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .cardShadow()
    }

    // MARK: - Page 2

    @ViewBuilder
    private func reportPage2() -> some View {
        HStack(spacing: 0) {
            // Left pink border
            Rectangle()
                .fill(AppTheme.Colors.reportBorderLeft)
                .frame(width: 4)

            // Content
            VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                        Text("HEALTH REPORT")
                            .font(AppTheme.Fonts.title3)
                            .foregroundColor(AppTheme.Colors.reportHeaderText)
                            .fontWeight(.bold)

                        HStack(spacing: AppTheme.Spacing.xs) {
                            Text("Made by Bloom")
                                .font(AppTheme.Fonts.subheadline)
                                .foregroundColor(AppTheme.Colors.reportHeaderText)

                            Image(systemName: "leaf.fill")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.Colors.reportHeaderText)
                        }
                    }

                    Spacer()
                }

                // Section title
                Text("Your average cycle with commonly logged events")
                    .font(AppTheme.Fonts.bodyBold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                // Description
                Text("The chart below shows a generalized view of your average cycle, highlighting the most frequently logged symptoms, moods, and other events across your tracked cycles.")
                    .font(AppTheme.Fonts.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineSpacing(4)

                // Info note
                HStack(alignment: .top, spacing: AppTheme.Spacing.sm) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.Colors.textTertiary)

                    Text("This overview is based on your tracked data and may not represent every cycle variation. Always consult your healthcare provider for personalized medical advice.")
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
            .padding(AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.reportCardBg)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .cardShadow()
    }
}

#Preview {
    NavigationStack {
        ReportPreviewView()
    }
}
