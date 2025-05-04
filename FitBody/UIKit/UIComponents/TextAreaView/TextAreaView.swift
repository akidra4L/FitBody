import SnapKit
import UIKit

// MARK: - TextAreaViewDelegate

@MainActor
protocol TextAreaViewDelegate: AnyObject {
    func textAreaView(_ textAreaView: TextAreaView, didChangeText text: String)
    func didEndEditingText(in textAreaView: TextAreaView)
}

// MARK: - TextAreaView

@MainActor
final class TextAreaView: UIStackView {
    typealias InitialParameters = TextAreaInitialParameters
    typealias Delegate = TextAreaViewDelegate

    enum State: Hashable {
        case active
        case error
        case normal
    }

    var state = State.normal {
        didSet { configureViews() }
    }

    var text = "" {
        didSet { textView.text = text }
    }

    lazy var title = initialParameters.title {
        didSet {
            titleLabel.isHidden = (title == nil)
            titleLabel.text = title
        }
    }

    lazy var placeholder = initialParameters.placeholder {
        didSet { configureTextView() }
    }

    private var accessitives: [State: String?] = [:]

    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    private lazy var textView = makeTextView()
    private lazy var assistiveLabel = UILabel(with: Fonts.headline5)

    private let initialParameters: InitialParameters
    private weak var delegate: Delegate?

    init(with initialParameters: InitialParameters, and delegate: Delegate?) {
        self.initialParameters = initialParameters
        self.delegate = delegate
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        textView.becomeFirstResponder()
    }

    func setAccessitive(_ accessitive: String, forState state: State) {
        switch state {
        case .normal, .active:
            accessitives[.normal] = accessitive
            accessitives[.active] = accessitive
        case .error:
            accessitives[state] = accessitive
        }

        configureViews()
    }

    private func configureTextView() {
        if text.isEmpty {
            textView.text = placeholder
            textView.textColor = Colors.textTertiary
            textView.font = Fonts.body3
        } else {
            textView.textColor = Colors.textPrimary
            textView.font = Fonts.body1
        }
    }

    private func setup() {
        axis = .vertical
        [titleLabel, subtitleLabel, textView, assistiveLabel].forEach { addArrangedSubview($0) }
        spacing = 8
        setCustomSpacing(12, after: titleLabel)

        setupConstraints()
        setupInitialText()
        configureTextView()
        configureViews()
    }

    private func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.height.equalTo(128)
        }
    }

    private func setupInitialText() {
        text = initialParameters.text ?? ""
    }

    private func configureBorderColor() {
        switch state {
        case .active:
            textView.layer.borderColor = Colors.fillPrimary.cgColor
        case .error:
            textView.layer.borderColor = Colors.textError.cgColor
        case .normal:
            textView.layer.borderColor = Colors.fillStroke.cgColor
        }
    }

    private func configureViews() {
        configureBorderColor()

        switch state {
        case .active:
            textView.backgroundColor = Colors.fillInputPressed
            textView.layer.borderWidth = 2
            assistiveLabel.textColor = Colors.textSecondary
        case .error:
            textView.backgroundColor = Colors.fillInput
            textView.layer.borderWidth = 2
            assistiveLabel.textColor = Colors.textError
        case .normal:
            textView.backgroundColor = Colors.fillInput
            textView.layer.borderWidth = 0.5
            assistiveLabel.textColor = Colors.textSecondary
        }

        assistiveLabel.isHidden = (accessitives[state] == nil)
        assistiveLabel.text = accessitives[state] ?? ""
    }

    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.isHidden = (title == nil)
        label.text = title
        label.textColor = Colors.textPrimary
        return label
    }

    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.isHidden = (initialParameters.subtitle == nil)
        label.text = initialParameters.subtitle
        label.textColor = Colors.textSecondary
        return label
    }

    private func makeTextView() -> UITextView {
        let textView = UITextView()
        textView.delegate = self
        textView.font = Fonts.body2
        textView.layer.cornerRadius = 12
        textView.scrollIndicatorInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 4)
        textView.textColor = Colors.textTertiary
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textView
    }
}

// MARK: - UITextViewDelegate

extension TextAreaView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        state = .active
        text = textView.text
        delegate?.textAreaView(self, didChangeText: textView.text)
        configureTextView()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        state = .active
        guard text.nilIfEmpty == nil else {
            return
        }

        textView.selectedTextRange = textView.textRange(
            from: textView.beginningOfDocument,
            to: textView.beginningOfDocument
        )
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if state == .active {
            state = .normal
        }

        delegate?.didEndEditingText(in: self)
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        if self.text.nilIfEmpty == nil, !text.isEmpty {
            textView.text = nil
        }

        return true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        guard
            window != nil,
            text.nilIfEmpty == nil,
            textView.text == placeholder
        else {
            return
        }

        textView.selectedTextRange = textView.textRange(
            from: textView.beginningOfDocument,
            to: textView.beginningOfDocument
        )
    }
}

// MARK: - TextAreaViewDelegate + Default

extension TextAreaViewDelegate {
    func didEndEditingText(in textAreaView: TextAreaView) {}
}
