import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var visibleMessages: [ChatMessage] = []
    @Published var isTyping: Bool = false
    @Published var chatProgress: CGFloat = 0

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
}
