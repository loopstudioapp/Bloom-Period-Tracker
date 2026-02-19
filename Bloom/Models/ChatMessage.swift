import SwiftUI

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let timestamp: Date

    init(id: UUID = UUID(), text: String, isFromUser: Bool = false, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.isFromUser = isFromUser
        self.timestamp = timestamp
    }
}

struct ChatConversation {
    static let healthAssistantIntro: [ChatMessage] = [
        ChatMessage(text: "Hi! Your Bloom Health Assistant here 👋"),
        ChatMessage(text: "I noticed that you logged mood swings."),
        ChatMessage(text: "Dealing with mood swings can be really hard. Bloom is here to support you ❤️"),
        ChatMessage(text: "Let's run through a few questions to check if your mood swings might need more attention.")
    ]

    static let cycleReportIntro: [ChatMessage] = [
        ChatMessage(text: "Hi! This is Bloom Health Assistant."),
        ChatMessage(text: "I've prepared your very first personalized cycle report!\n\nYou'll get one of these at the end of every cycle. Let's look back at your most recent one, from Dec 26 – Jan 24."),
        ChatMessage(text: "In this report, you can learn:\n– If your period length and intensity are in the normal range\n– What symptoms and moods you experienced during this cycle\n– If anything related to your cycle needs further attention")
    ]
}
