import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var visibleMessages: [ChatMessage] = []
    @Published var isTyping: Bool = false
    @Published var chatProgress: CGFloat = 0

    // MARK: - Interactive Chat Properties
    @Published var inputText: String = ""
    @Published var isStreaming: Bool = false
    @Published var errorMessage: String? = nil

    private var conversationHistory: [OpenRouterService.Message] = []

    // MARK: - Scripted Playback (used by HealthAssistantChatView, CycleReportChatView)

    private var allMessages: [ChatMessage] = []
    private var currentIndex: Int = 0

    func loadConversation(_ messages: [ChatMessage]) {
        allMessages = messages
        currentIndex = 0
        visibleMessages = []
        showNextMessage()
    }

    func showNextMessage() {
        guard currentIndex < allMessages.count else {
            chatProgress = 1.0
            return
        }

        isTyping = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.isTyping = false
            self.visibleMessages.append(self.allMessages[self.currentIndex])
            self.currentIndex += 1
            self.chatProgress = CGFloat(self.currentIndex) / CGFloat(self.allMessages.count)

            if self.currentIndex < self.allMessages.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.showNextMessage()
                }
            }
        }
    }

    // MARK: - Interactive AI Chat

    func loadWelcomeMessage() {
        guard visibleMessages.isEmpty else { return }
        let welcome = ChatMessage(
            text: "Hi there! I'm Bloom, your cycle health assistant. Ask me anything about periods, symptoms, fertility, or cycle wellness! 🌸",
            isFromUser: false
        )
        visibleMessages.append(welcome)
    }

    func sendMessage() async {
        let userText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userText.isEmpty else { return }

        inputText = ""
        errorMessage = nil

        let userMessage = ChatMessage(text: userText, isFromUser: true)
        visibleMessages.append(userMessage)

        conversationHistory.append(
            OpenRouterService.Message(role: "user", content: userText)
        )

        isTyping = true
        isStreaming = true

        let assistantId = UUID()
        var streamedText = ""
        var assistantAdded = false

        await OpenRouterService.shared.streamCompletion(
            messages: conversationHistory,
            onToken: { [weak self] token in
                guard let self = self else { return }
                self.isTyping = false
                streamedText += token

                if !assistantAdded {
                    self.visibleMessages.append(
                        ChatMessage(id: assistantId, text: streamedText, isFromUser: false)
                    )
                    assistantAdded = true
                } else if let index = self.visibleMessages.lastIndex(where: { $0.id == assistantId }) {
                    self.visibleMessages[index] = ChatMessage(
                        id: assistantId, text: streamedText, isFromUser: false
                    )
                }
            },
            onComplete: { [weak self] in
                guard let self = self else { return }
                self.isStreaming = false
                self.isTyping = false
                self.conversationHistory.append(
                    OpenRouterService.Message(role: "assistant", content: streamedText)
                )
            },
            onError: { [weak self] error in
                guard let self = self else { return }
                self.isStreaming = false
                self.isTyping = false
                self.errorMessage = error.localizedDescription
            }
        )
    }

    func clearChat() {
        visibleMessages = []
        conversationHistory = []
        errorMessage = nil
        isTyping = false
        isStreaming = false
        loadWelcomeMessage()
    }
}
