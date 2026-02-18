import SwiftUI

struct CycleReportChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var showReport: Bool = false

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

            // MARK: - Go On Button
            goOnButton
        }
        .background(AppTheme.Colors.background)
        .onAppear {
            viewModel.loadConversation(ChatConversation.cycleReportIntro)
        }
        .fullScreenCover(isPresented: $showReport) {
            NavigationStack {
                ReportPreviewView()
            }
        }
    }

    // MARK: - Navigation Bar

    private var navBar: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            // Back button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(width: 36, height: 36)
            }
            .accessibilityLabel("Go back")

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

            // Invisible spacer to balance the back button
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

    // MARK: - Go On Button

    private var goOnButton: some View {
        Button(action: {
            showReport = true
        }) {
            Text("Go on")
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
    CycleReportChatView()
}
