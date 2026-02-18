import SwiftUI

struct TypingIndicator: View {
    @State private var dot1Opacity: Double = 0.3
    @State private var dot2Opacity: Double = 0.3
    @State private var dot3Opacity: Double = 0.3

    var body: some View {
        HStack {
            HStack(spacing: AppTheme.Spacing.xs) {
                Circle()
                    .fill(AppTheme.Colors.textSecondary)
                    .frame(width: 8, height: 8)
                    .opacity(dot1Opacity)
                Circle()
                    .fill(AppTheme.Colors.textSecondary)
                    .frame(width: 8, height: 8)
                    .opacity(dot2Opacity)
                Circle()
                    .fill(AppTheme.Colors.textSecondary)
                    .frame(width: 8, height: 8)
                    .opacity(dot3Opacity)
            }
            .padding(AppTheme.Spacing.md)
            .background(AppTheme.Colors.assistantBubbleBg)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))

            Spacer()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                dot1Opacity = 1.0
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.2)) {
                dot2Opacity = 1.0
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever().delay(0.4)) {
                dot3Opacity = 1.0
            }
        }
    }
}
