import Foundation

@MainActor
class OpenRouterService: ObservableObject {
    static let shared = OpenRouterService()

    // MARK: - Configuration
    static var apiKey: String = Secrets.openRouterAPIKey

    private let baseURL = "https://openrouter.ai/api/v1/chat/completions"
    private let model = "x-ai/grok-4.1-fast"

    private let baseSystemPrompt = """
    You are Bloom, a friendly and knowledgeable period and cycle health assistant \
    inside the Bloom Period Tracker app. You help users understand their menstrual \
    cycle, symptoms, fertility windows, and overall reproductive health. \
    You are warm, supportive, non-judgmental, and evidence-based. \
    Keep responses concise and conversational. \
    Use emoji occasionally to feel approachable. \
    Never provide medical diagnoses — always recommend consulting a healthcare \
    provider for medical concerns. \
    When the user asks about their cycle, refer to the live cycle data below \
    to give personalized answers. If no cycle data is available, encourage them \
    to log their period in the app.
    """

    /// Builds the full system prompt with the user's live cycle data injected.
    private var systemPrompt: String {
        let cycle = CycleService.shared
        var prompt = baseSystemPrompt

        guard cycle.hasData else {
            prompt += "\n\nThe user has not logged any period data yet."
            return prompt
        }

        let df = DateFormatter()
        df.dateStyle = .medium

        let phase = cycle.currentPhase
        let phaseNames: [CyclePhaseType: String] = [
            .period: "menstrual (on their period)",
            .follicular: "follicular",
            .fertile: "fertile window",
            .ovulation: "ovulation",
            .luteal: "luteal"
        ]

        var lines: [String] = []
        lines.append("\n\nUser's live cycle data (today is \(df.string(from: Date()))):")
        lines.append("- Cycle length: \(cycle.cycleLength) days")
        lines.append("- Period length: \(cycle.periodLength) days")
        lines.append("- Current cycle day: \(cycle.currentCycleDay)")
        lines.append("- Current phase: \(phaseNames[phase] ?? phase.rawValue)")

        if cycle.isOnPeriod {
            lines.append("- Period day: \(cycle.periodDay) of \(cycle.periodLength)")
        }

        lines.append("- Fertile window starts in: \(cycle.fertileDaysAway) days")
        lines.append("- Predicted ovulation day: day \(cycle.ovulationDay) of cycle")

        if let start = cycle.currentCycleStartDate {
            let nextPeriod = cycle.nextCycleStart(from: start)
            lines.append("- Next predicted period: \(df.string(from: nextPeriod))")
        }

        prompt += lines.joined(separator: "\n")
        return prompt
    }

    // MARK: - Types

    struct Message: Codable {
        let role: String
        let content: String
    }

    private struct RequestBody: Codable {
        let model: String
        let messages: [Message]
        let stream: Bool
    }

    private struct StreamChunk: Codable {
        struct Choice: Codable {
            struct Delta: Codable {
                let content: String?
            }
            let delta: Delta
            let finish_reason: String?
        }
        let choices: [Choice]
    }

    enum ServiceError: Error, LocalizedError {
        case invalidResponse
        case httpError(Int)
        case apiKeyMissing

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid response from server"
            case .httpError(let code): return "Server error (\(code))"
            case .apiKeyMissing: return "API key not configured. Set your OpenRouter API key to use Bloom AI."
            }
        }
    }

    // MARK: - Streaming API

    func streamCompletion(
        messages: [Message],
        onToken: @escaping (String) -> Void,
        onComplete: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) async {
        guard !Self.apiKey.isEmpty else {
            onError(ServiceError.apiKeyMissing)
            return
        }

        var allMessages = [Message(role: "system", content: systemPrompt)]
        allMessages.append(contentsOf: messages)

        let body = RequestBody(model: model, messages: allMessages, stream: true)

        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Self.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bloom Period Tracker", forHTTPHeaderField: "HTTP-Referer")
        request.setValue("Bloom", forHTTPHeaderField: "X-Title")
        request.httpBody = try? JSONEncoder().encode(body)

        do {
            let (bytes, response) = try await URLSession.shared.bytes(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                onError(ServiceError.invalidResponse)
                return
            }

            guard httpResponse.statusCode == 200 else {
                onError(ServiceError.httpError(httpResponse.statusCode))
                return
            }

            for try await line in bytes.lines {
                guard line.hasPrefix("data: ") else { continue }
                let json = String(line.dropFirst(6))
                if json == "[DONE]" { break }

                if let data = json.data(using: .utf8),
                   let chunk = try? JSONDecoder().decode(StreamChunk.self, from: data),
                   let content = chunk.choices.first?.delta.content {
                    onToken(content)
                }
            }
            onComplete()
        } catch {
            onError(error)
        }
    }
}
