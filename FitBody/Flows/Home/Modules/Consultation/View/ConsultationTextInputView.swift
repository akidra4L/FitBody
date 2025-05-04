import UIKit
import SnapKit

// MARK: - ConsultationTextInputViewDelegate

@MainActor
protocol ConsultationTextInputViewDelegate: AnyObject {
    func consultationTextInputView(
        _ view: ConsultationTextInputView,
        didTapActionButton button: LoadableButton
    )
}

// MARK: - ConsultationTextInputView

@MainActor
final class ConsultationTextInputView: UIView {
    typealias Delegate = ConsultationTextInputViewDelegate

    var text: String? {
        textView.body
    }

    private lazy var textView = ConsultationTextView(with: self)
    private lazy var actionButton = makeActionButton()

    private weak var delegate: Delegate?

    init(with delegate: Delegate?) {
        self.delegate = delegate
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func reset() {
        actionButton.isEnabled = false
        textView.reset()
    }

    @objc
    private func actionButtonDidTap() {
        delegate?.consultationTextInputView(self, didTapActionButton: actionButton)
    }

    private func setup() {
        [textView, actionButton].forEach { addSubview($0) }
        backgroundColor = Colors.fillInput
        layer.borderColor = Colors.fillStroke.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 12

        setupConstraints()
    }

    private func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(actionButton.snp.leading).offset(-8)
            make.height.lessThanOrEqualTo(100)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func makeActionButton() -> LoadableButton {
        let button = PrimaryButton(size: .small)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.imageColors = [
            UIControl.State.normal.rawValue: .white,
            UIControl.State.disabled.rawValue: .white
        ]
        button.isEnabled = false
        button.setImage(Icons.arrowRight24x24)
        return button
    }
}

// MARK: - CommentTextViewDelegate

extension ConsultationTextInputView: ConsultationTextViewDelegate {
    func textDidChange(in textView: ConsultationTextView) {
        actionButton.isEnabled = (text?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty != nil)
    }
}
