import SwiftUI

struct FeelingSelector: View {
    let feelings: [Feeling]
    let selectedFeelings: Set<String>
    var onToggle: (String) -> Void = { _ in }

    var body: some View {
        HStack(spacing: AppTheme.Spacing.lg) {
            ForEach(feelings) { feeling in
                Button(action: { onToggle(feeling.name) }) {
                    VStack(spacing: AppTheme.Spacing.xs) {
                        ZStack(alignment: .bottomTrailing) {
                            Text(feeling.emoji)
                                .font(.system(size: 28))
                                .frame(width: 56, height: 56)
                                .background(AppTheme.Colors.emojiCircleBg)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(selectedFeelings.contains(feeling.name) ? AppTheme.Colors.checkmarkBadgeBg : Color.clear, lineWidth: 2)
                                )

                            if selectedFeelings.contains(feeling.name) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(AppTheme.Colors.checkmarkBadgeBg)
                                    .background(Color.white.clipShape(Circle()))
                                    .offset(x: 4, y: 4)
                            }
                        }

                        Text(feeling.name)
                            .font(AppTheme.Fonts.caption)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}
