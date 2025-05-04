import Foundation

struct TextAreaInitialParameters: Sendable {
    let placeholder: String
    let text: String?
    let title: String?
    let subtitle: String?

    init(
        placeholder: String,
        text: String? = nil,
        title: String? = nil,
        subtitle: String? = nil
    ) {
        self.placeholder = placeholder
        self.text = text
        self.title = title
        self.subtitle = subtitle
    }
}
