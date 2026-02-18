import SwiftUI

struct HealthAssistantPhoneIllustration: View {
    private let width: CGFloat = 240
    private let height: CGFloat = 320

    var body: some View {
        ZStack {
            // Hands holding the phone
            handsHolding

            // Phone frame
            phoneFrame
        }
        .frame(width: width, height: height)
    }

    // MARK: - Phone Frame

    private var phoneFrame: some View {
        ZStack {
            // Phone border
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge)
                .stroke(AppTheme.Colors.textPrimary, lineWidth: 3)
                .frame(width: phoneWidth, height: phoneHeight)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge)
                        .fill(AppTheme.Colors.cardBackground)
                )

            // Chat content inside phone
            chatContent
        }
    }

    // MARK: - Chat Content

    private var chatContent: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Spacer()
                .frame(height: AppTheme.Spacing.xl)

            // Assistant message (left-aligned)
            HStack(spacing: AppTheme.Spacing.xs) {
                // Small pink circle icon
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: 14, height: 14)

                // Light blue bubble
                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                    .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.4))
                    .frame(width: phoneWidth * 0.55, height: height * 0.06)

                Spacer()
            }
            .padding(.horizontal, AppTheme.Spacing.sm)

            // Another assistant message
            HStack {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: 14, height: 14)

                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                    .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.4))
                    .frame(width: phoneWidth * 0.45, height: height * 0.05)

                Spacer()
            }
            .padding(.horizontal, AppTheme.Spacing.sm)

            Spacer()
                .frame(height: AppTheme.Spacing.xs)

            // User message (right-aligned)
            HStack {
                Spacer()

                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: phoneWidth * 0.5, height: height * 0.055)
            }
            .padding(.horizontal, AppTheme.Spacing.sm)

            // Another user message
            HStack {
                Spacer()

                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: phoneWidth * 0.35, height: height * 0.045)
            }
            .padding(.horizontal, AppTheme.Spacing.sm)

            Spacer()
                .frame(height: AppTheme.Spacing.xs)

            // Typing indicator
            HStack(spacing: AppTheme.Spacing.xs) {
                Circle()
                    .fill(AppTheme.Colors.primaryPink)
                    .frame(width: 14, height: 14)

                HStack(spacing: AppTheme.Spacing.xxs + 1) {
                    ForEach(0..<3, id: \.self) { _ in
                        Circle()
                            .fill(AppTheme.Colors.textSecondary.opacity(0.4))
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.sm)
                .padding(.vertical, AppTheme.Spacing.xs)
                .background(
                    Capsule()
                        .fill(AppTheme.Colors.lightBlueIllustration.opacity(0.3))
                )

                Spacer()
            }
            .padding(.horizontal, AppTheme.Spacing.sm)

            Spacer()
                .frame(height: AppTheme.Spacing.md)
        }
        .frame(width: phoneWidth, height: phoneHeight)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.xlarge))
    }

    // MARK: - Hands Holding Phone

    private var handsHolding: some View {
        Group {
            // Left hand
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.12, height: height * 0.2)
                .rotationEffect(.degrees(10))
                .offset(x: -width * 0.3, y: height * 0.08)

            // Left thumb
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.06, height: height * 0.08)
                .rotationEffect(.degrees(30))
                .offset(x: -width * 0.22, y: height * 0.02)

            // Right hand
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.12, height: height * 0.2)
                .rotationEffect(.degrees(-10))
                .offset(x: width * 0.3, y: height * 0.08)

            // Right thumb
            Capsule()
                .fill(AppTheme.Colors.skinToneMedium)
                .frame(width: width * 0.06, height: height * 0.08)
                .rotationEffect(.degrees(-30))
                .offset(x: width * 0.22, y: height * 0.02)
        }
    }

    // MARK: - Sizes

    private var phoneWidth: CGFloat { width * 0.55 }
    private var phoneHeight: CGFloat { height * 0.75 }
}

#Preview {
    HealthAssistantPhoneIllustration()
        .padding(AppTheme.Spacing.xxl)
        .background(AppTheme.Colors.backgroundPink)
}
