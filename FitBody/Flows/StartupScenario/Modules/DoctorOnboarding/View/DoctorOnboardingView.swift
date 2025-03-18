import UIKit
import SnapKit

// MARK: - DoctorOnboardingViewDelegate

protocol DoctorOnboardingViewDelegate: AnyObject {
    func didTapActionButton(in view: DoctorOnboardingView)
}

// MARK: - DoctorOnboardingView

final class DoctorOnboardingView: UIView {
    typealias Delegate = DoctorOnboardingViewDelegate
    
    private lazy var appNameLabel = makeAppNameLabel()
    private lazy var illustrationImageView = UIImageView(image: Illustrations.doctorOnboardingIllustration)
    private lazy var containerView = makeContainerView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
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
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }
    
    private func setup() {
        [appNameLabel, illustrationImageView, containerView].forEach { addSubview($0) }
        backgroundColor = Colors.fillPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        illustrationImageView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top)
        }
        containerView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(actionButton.snp.top).offset(-32)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeAppNameLabel() -> UILabel {
        let label = UILabel(with: Fonts.title1)
        label.text = "FitBody"
        label.textAlignment = .center
        label.textColor = Colors.fillInput
        return label
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [titleLabel, subtitleLabel, actionButton].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillInput
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.numberOfLines = 2
        label.text = "More comfortable chat with the doctor"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.text = "Book an appointment with doctor.\nChat with doctor and get consultation"
        label.textAlignment = .center
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Get Started", for: .normal)
        return button
    }
}
