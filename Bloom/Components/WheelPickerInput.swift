import SwiftUI

struct WheelPickerInput: View {
    let title: String
    @Binding var primaryValue: Int
    @Binding var secondaryValue: Int
    let primaryRange: ClosedRange<Int>
    let secondaryRange: ClosedRange<Int>
    let primaryLabel: String
    let secondaryLabel: String
    let separator: String
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: AppTheme.Spacing.xl) {
            Spacer()

            // Title
            Text(title)
                .font(AppTheme.Fonts.title1)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppTheme.Spacing.xl)

            // Display card showing selected values
            displayCard
                .padding(.horizontal, AppTheme.Spacing.xl)

            // Wheel pickers
            pickerRow
                .frame(height: pickerHeight)
                .padding(.horizontal, AppTheme.Spacing.xl)

            Spacer()

            // Next button
            PillButton(
                title: "Next",
                style: .primary,
                action: onNext
            )
            .padding(.horizontal, AppTheme.Spacing.xl)
            .padding(.bottom, AppTheme.Spacing.md)
        }
        .background(AppTheme.Colors.background)
    }

    // MARK: - Private Views

    private var displayCard: some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            // Primary value and label
            HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                Text("\(primaryValue)")
                    .font(.system(size: displayFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Text(primaryLabel)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Separator
            Text(separator)
                .font(.system(size: displayFontSize, weight: .bold, design: .rounded))
                .foregroundColor(AppTheme.Colors.textPrimary)

            // Secondary value and label
            HStack(alignment: .firstTextBaseline, spacing: AppTheme.Spacing.xs) {
                Text("\(secondaryValue)")
                    .font(.system(size: displayFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Text(secondaryLabel)
                    .font(AppTheme.Fonts.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppTheme.Spacing.lg)
        .background(AppTheme.Colors.optionBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
    }

    private var pickerRow: some View {
        HStack(spacing: 0) {
            // Primary picker
            Picker("", selection: $primaryValue) {
                ForEach(Array(primaryRange), id: \.self) { value in
                    Text("\(value)")
                        .font(AppTheme.Fonts.title2)
                        .tag(value)
                }
            }
            .pickerStyle(.wheel)

            // Secondary picker
            Picker("", selection: $secondaryValue) {
                ForEach(Array(secondaryRange), id: \.self) { value in
                    Text("\(value)")
                        .font(AppTheme.Fonts.title2)
                        .tag(value)
                }
            }
            .pickerStyle(.wheel)
        }
    }

    // MARK: - Private Helpers

    private var displayFontSize: CGFloat { 34 }
    private var pickerHeight: CGFloat { 180 }
}

#Preview("Height Picker") {
    struct HeightPreview: View {
        @State private var feet = 5
        @State private var inches = 6

        var body: some View {
            WheelPickerInput(
                title: "How tall are you?",
                primaryValue: $feet,
                secondaryValue: $inches,
                primaryRange: 3...7,
                secondaryRange: 0...11,
                primaryLabel: "ft",
                secondaryLabel: "in",
                separator: " ",
                onNext: {}
            )
        }
    }

    return HeightPreview()
}

#Preview("Weight Picker") {
    struct WeightPreview: View {
        @State private var whole = 130
        @State private var decimal = 0

        var body: some View {
            WheelPickerInput(
                title: "How much do you weigh?",
                primaryValue: $whole,
                secondaryValue: $decimal,
                primaryRange: 66...400,
                secondaryRange: 0...9,
                primaryLabel: "lb",
                secondaryLabel: "",
                separator: ".",
                onNext: {}
            )
        }
    }

    return WeightPreview()
}
