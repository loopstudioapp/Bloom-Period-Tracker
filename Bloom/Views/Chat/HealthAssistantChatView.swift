import SwiftUI

struct HealthAssistantChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Navigation Bar
            navBar

            // MARK: - Progress Bar
            progressBar

            // MARK: - Chat Messages
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: AppTheme.Spacing.sm) {
                        ForEach(viewModel.visibleMessages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }

                        if viewModel.isTyping {
                            TypingIndicator()
                                .id("typing")
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.md)
                    .padding(.bottom, AppTheme.Spacing.xl)
                }
                .onChange(of: viewModel.visibleMessages.count) {
                    withAnimation(AppTheme.Animation.standard) {
                        if let lastMessage = viewModel.visibleMessages.last {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: viewModel.isTyping) {
                    if viewModel.isTyping {
                        withAnimation(AppTheme.Animation.standard) {
                            proxy.scrollTo("typing", anchor: .bottom)
                        }
                    }
                }
            }

            // MARK: - OK Button
            okButton
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            viewModel.loadConversation(ChatConversation.healthAssistantIntro)
        }
    }

    // MARK: - Navigation Bar

    private var navBar: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            // Close button
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(width: 36, height: 36)
            }
            .accessibilityLabel("Close health assistant")

            Spacer()

            // Pink circle avatar + title
            HStack(spacing: AppTheme.Spacing.sm) {
                ZStack {
                    Circle()
                        .fill(AppTheme.Colors.assistantAvatarBg)
                        .frame(width: 32, height: 32)

                    Image(systemName: "leaf.fill")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.Colors.textWhite)
                }

                Text("Bloom")
                    .font(AppTheme.Fonts.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Spacer()

            // Invisible spacer to balance the X button
            Color.clear
                .frame(width: 36, height: 36)
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.sm)
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(AppTheme.Colors.progressTrack)
                    .frame(height: AppTheme.Spacing.xxs)

                Rectangle()
                    .fill(AppTheme.Colors.progressBarThin)
                    .frame(width: geometry.size.width * viewModel.chatProgress, height: AppTheme.Spacing.xxs)
                    .animation(AppTheme.Animation.standard, value: viewModel.chatProgress)
            }
        }
        .frame(height: AppTheme.Spacing.xxs)
    }

    // MARK: - OK Button

    private var okButton: some View {
        Button(action: { dismiss() }) {
            Text("OK")
                .font(AppTheme.Fonts.bodyBold)
                .foregroundColor(AppTheme.Colors.textWhite)
                .frame(maxWidth: .infinity)
                .frame(height: AppTheme.ButtonHeight.primary)
                .background(AppTheme.Colors.primaryPink)
                .clipShape(Capsule())
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.bottom, AppTheme.Spacing.md)
    }
}

#Preview {
    HealthAssistantChatView()
}
