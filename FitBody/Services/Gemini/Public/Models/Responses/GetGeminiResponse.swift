import Foundation

// MARK: - GetGeminiResponse

struct GetGeminiResponse: Decodable, Sendable {
    let candidates: [Candidate]?
    let promptFeedback: PromptFeedback?

    struct Candidate: Decodable, Sendable {
        let content: Content?
        let finishReason: String?
        let index: Int?
        let safetyRatings: [SafetyRating]?
    }

    struct Content: Decodable, Sendable {
        let parts: [Part]?
        let role: String?
    }

    struct Part: Decodable, Sendable {
        let text: String?
    }

    struct PromptFeedback: Decodable, Sendable {
        let safetyRatings: [SafetyRating]?
    }

    struct SafetyRating: Decodable, Sendable {
        let category: String?
        let probability: String?
    }

    var generatedText: String? {
        return candidates?.first?
            .content?.parts?.first?
            .text
    }
}
