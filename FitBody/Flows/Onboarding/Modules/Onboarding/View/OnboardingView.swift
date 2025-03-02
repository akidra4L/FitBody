import UIKit
import SnapKit

protocol OnboardingViewDelegate: AnyObject {
    func didTapActionButton(in view: OnboardingView)
}

final class OnboardingView: UIView {
    typealias ViewModel = OnboardingViewModel
    typealias Delegate = OnboardingViewDelegate
    
    private lazy var illustrationImageView = UIImageView(image: viewModel.illustration)
    private lazy var titleLabel = makeTitleLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var actionButton = makeActionButton()
    
    private let viewModel: ViewModel
    private weak var delegate: Delegate?
    
    init(with viewModel: ViewModel, and delegate: Delegate?) {
        self.viewModel = viewModel
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
            descriptionLabel,
            actionButton
        ].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(406)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(actionButton.snp.top).offset(-12)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title0)
        label.numberOfLines = 3
        label.text = viewModel.title
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.text = viewModel.description
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle(viewModel.actionButtonTitle, for: .normal)
        return button
    }
}
