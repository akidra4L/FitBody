import UIKit
import SnapKit

// MARK: - Constants

private enum Constants {
    static let maxCharacters = 500
}

// MARK: - ConsultationTextViewDelegate

@MainActor
protocol ConsultationTextViewDelegate: AnyObject {
    func textDidChange(in textView: ConsultationTextView)
}

// MARK: - ConsultationTextView

@MainActor
final class ConsultationTextView: UITextView {
    typealias TextViewDelegate = ConsultationTextViewDelegate

    override var intrinsicContentSize: CGSize {
        let size = sizeThatFits(
            CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        )
        let clampedHeight = min(size.height, 76)
        return CGSize(width: super.intrinsicContentSize.width, height: clampedHeight)
    }

    var body: String? {
        isPlaceholderActive ? nil : text
    }

    private var isPlaceholderActive = true {
        didSet {
            text = isPlaceholderActive ? placeholder : nil
            textColor = isPlaceholderActive ? Colors.textTertiary : Colors.textPrimary
        }
    }

    private let placeholder = "What is your issue?"

    private weak var textViewDelegate: TextViewDelegate?

    init(with textViewDelegate: TextViewDelegate?) {
        self.textViewDelegate = textViewDelegate
        super.init(frame: .zero, textContainer: nil)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func paste(_ sender: Any?) {
        guard let pastedText = UIPasteboard.general.string else {
            return
        }

        if isPlaceholderActive {
            isPlaceholderActive = false
            text = String(pastedText.prefix(Constants.maxCharacters))
        } else {
            let currentText = text ?? ""
            let remainingCharacters = Constants.maxCharacters - currentText.count

            guard remainingCharacters > 0 else {
                return
            }

            let truncatedText = String(pastedText.prefix(remainingCharacters))
            if let selectedTextRange {
                replace(selectedTextRange, withText: truncatedText)
            } else {
                text.append(truncatedText)
            }
        }

        textViewDelegate?.textDidChange(in: self)
    }

    func reset() {
        configurePlaceholder()

        invalidateIntrinsicContentSize()
    }

    private func setup() {
        backgroundColor = .clear
        delegate = self
        font = Fonts.body3
        text = placeholder
        textColor = Colors.textTertiary
        textContainerInset = .zero

        configurePlaceholder()
    }

    private func configurePlaceholder() {
        isPlaceholderActive = true

        resetSelectionToStart()
    }

    private func resetSelectionToStart() {
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
    }
}

// MARK: - UITextViewDelegate

extension ConsultationTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isPlaceholderActive {
            resetSelectionToStart()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        text = text.trimmingCharacters(in: .whitespaces)
        if text.isEmpty {
            configurePlaceholder()
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        invalidateIntrinsicContentSize()

        if text.isEmpty {
            configurePlaceholder()
        } else if isPlaceholderActive {
            isPlaceholderActive = false
        }

        textViewDelegate?.textDidChange(in: self)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        guard isPlaceholderActive, window != nil else {
            return
        }

        resetSelectionToStart()
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText replacement: String
    ) -> Bool {
        if isPlaceholderActive, !replacement.isEmpty {
            isPlaceholderActive = false
            return true
        }

        let currentText = textView.text ?? ""
        guard let textRange = Range(range, in: currentText) else {
            return false
        }

        let updatedText = currentText.replacingCharacters(in: textRange, with: replacement)
        if updatedText.count > Constants.maxCharacters {
            return false
        }

        return true
    }
}
