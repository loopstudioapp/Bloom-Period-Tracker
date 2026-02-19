import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromUser { Spacer() }

            Text(message.text)
                .font(AppTheme.Fonts.body)
                .foregroundColor(AppTheme.Colors.assistantBubbleText)
                .padding(AppTheme.Spacing.md)
                .background(message.isFromUser ? AppTheme.Colors.primaryPink.opacity(0.1) : AppTheme.Colors.assistantBubbleBg)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))
                .frame(maxWidth: min(UIScreen.main.bounds.width * 0.8, 500), alignment: message.isFromUser ? .trailing : .leading)

            if !message.isFromUser { Spacer() }
        }
    }
}
