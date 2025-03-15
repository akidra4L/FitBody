import UIKit
import SnapKit

// MARK: - AuthSuccessViewDelegate

protocol AuthSuccessViewDelegate: AnyObject {
    func didTapActionButton(in view: AuthSuccessView)
}

// MARK: - AuthSuccessView

final class AuthSuccessView: UIView {
    typealias Delegate = AuthSuccessViewDelegate
    
    private lazy var illustrationImageView = UIImageView(image: Illustrations.authSuccessIllustration)
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    private lazy var actionButton = makeActionButton()
    
    private let name: String
    private weak var delegate: Delegate?
    
    init(with name: String, and delegate: Delegate?) {
        self.name = name
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }
    
    private func setup() {
        [
            illustrationImageView,
            titleLabel,
            subtitleLabel,
            actionButton
        ].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(40)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title1)
        label.text = "Welcome, \(name)!"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.text = "You are all set now, let’s reach your goals together with us"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Go to Home", for: .normal)
        return button
    }
}
