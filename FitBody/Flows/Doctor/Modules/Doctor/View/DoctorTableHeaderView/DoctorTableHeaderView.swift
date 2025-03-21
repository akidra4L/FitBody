import UIKit
import SnapKit
import Kingfisher

final class DoctorTableHeaderView: UIView {
    private lazy var containerView = makeContainerView()
    private lazy var illustrationImageView = makeIllustrationImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    private lazy var addressView = AddressView()
    
    override init(frame: CGRect) {
        super.init(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: .zero, height: 360)
            )
        )
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: DoctorTableHeaderViewModel) {
        illustrationImageView.kf.setImage(with: viewModel.illustration)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        addressView.configure(with: viewModel.address)
        
        layoutIfNeeded()
    }
    
    private func setup() {
        addSubview(containerView)
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
            )
        }
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(240)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
        addressView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            illustrationImageView,
            titleLabel,
            subtitleLabel,
            addressView
        ].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.clipsToBounds = true
        view.layer.applyShadow(
            opacity: 1,
            offset: CGSize(width: 0, height: 12),
            blur: 12,
            spread: -10
        )
        view.layer.cornerRadius = 12
        view.layer.shadowColor = Colors.fillShadowPrimary.withAlphaComponent(0.12).cgColor
        return view
    }
    
    private func makeIllustrationImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.textColor = Colors.textSecondary
        return label
    }
}
