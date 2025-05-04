import UIKit
import SnapKit

final class ConsultationBottomView: UIView {
    typealias Delegate = ConsultationTextInputViewDelegate
    
    private lazy var disclaimerLabel = makeDisclaimerLabel()
    private lazy var textInputView = ConsultationTextInputView(with: delegate)
    
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
        textInputView.reset()
    }
    
    private func setup() {
        [disclaimerLabel, textInputView].forEach { addSubview($0) }
        backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        disclaimerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        textInputView.snp.makeConstraints { make in
            make.top.equalTo(disclaimerLabel.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func makeDisclaimerLabel() -> UILabel {
        let label = UILabel(with: Fonts.title6)
        label.numberOfLines = 2
        label.text = "First review is making by AI assistant\nPlease, consultate with a doctor firstly"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
}
