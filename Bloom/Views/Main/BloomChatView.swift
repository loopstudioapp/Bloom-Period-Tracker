import SwiftUI

struct BloomChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                chatScrollView

                chatInputBar
            }
            .background(AppTheme.Colors.background)
            .navigationTitle("Bloom AI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.clearChat() }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }
            }
            .onAppear {
                viewModel.loadWelcomeMessage()
            }
        }
    }

    // MARK: - Chat Scroll View

    private var chatScrollView: some View {
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

                    if let error = viewModel.errorMessage {
                        errorBanner(error)
                            .id("error")
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.top, AppTheme.Spacing.md)
                .padding(.bottom, AppTheme.Spacing.xl)
                .constrainedWidth()
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: viewModel.visibleMessages.count) {
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: viewModel.visibleMessages.last?.text) {
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: viewModel.isTyping) {
                if viewModel.isTyping {
                    withAnimation(AppTheme.Animation.standard) {
                        proxy.scrollTo("typing", anchor: .bottom)
                    }
                }
            }
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation(AppTheme.Animation.standard) {
            if let lastMessage = viewModel.visibleMessages.last {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }

    // MARK: - Chat Input Bar

    private var chatInputBar: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            TextField("Ask Bloom anything...", text: $viewModel.inputText, axis: .vertical)
                .font(AppTheme.Fonts.body)
                .lineLimit(1...5)
                .focused($isInputFocused)
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.vertical, AppTheme.Spacing.sm)
                .background(AppTheme.Colors.assistantBubbleBg)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.large))

            Button(action: {
                Task { await viewModel.sendMessage() }
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(canSend ? AppTheme.Colors.primaryPink : AppTheme.Colors.textTertiary)
            }
            .disabled(!canSend)
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.sm)
        .background(AppTheme.Colors.background)
        .overlay(
            Divider(), alignment: .top
        )
    }

    private var canSend: Bool {
        !viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !viewModel.isStreaming
    }

    // MARK: - Error Banner

    private func errorBanner(_ message: String) -> some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(AppTheme.Colors.orangeAccent)
            Text(message)
                .font(AppTheme.Fonts.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
            Spacer()
        }
        .padding(AppTheme.Spacing.sm)
        .background(AppTheme.Colors.backgroundLight)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.small))
    }
}

#Preview {
    BloomChatView()
}
