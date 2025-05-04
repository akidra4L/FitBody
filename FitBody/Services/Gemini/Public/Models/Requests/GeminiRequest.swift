import Foundation

// MARK: - GeminiRequest

struct GeminiRequest: Encodable, Sendable {
    let contents: [Content]
    
    init(with prompt: String) {
        self.contents = [
            Content(
                parts: [Content.Part(text: prompt)]
            )
        ]
    }
}

// MARK: - GeminiRequest.Content

extension GeminiRequest {
    struct Content: Encodable, Sendable {
        let parts: [Part]
    }
}

// MARK: - GeminiRequest.Content.Part

extension GeminiRequest.Content {
    struct Part: Encodable, Sendable {
        let text: String
    }
}
