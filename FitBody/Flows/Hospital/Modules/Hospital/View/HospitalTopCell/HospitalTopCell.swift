import UIKit
import SnapKit
import Kingfisher

final class HospitalTopCell: UITableViewCell {
    private lazy var bannerImageView = makeBannerImageView()
    private lazy var bannerBottomView = makeBannerBottomView()
    private lazy var ratingView = RatingView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: HospitalTopViewModel) {
        bannerImageView.kf.setImage(with: viewModel.banner)
        ratingView.configure(with: viewModel.ratingViewModel)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    private func setup() {
        backgroundColor = .clear
        [
            bannerImageView,
            bannerBottomView,
            ratingView,
            titleLabel,
            descriptionLabel
        ].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(360)
        }
        bannerBottomView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(bannerImageView.snp.bottom)
            make.height.equalTo(24)
        }
        ratingView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().offset(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom)
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func makeBannerImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }
    
    private func makeBannerBottomView() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.fillBackgroundPrimary
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.numberOfLines = 0
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.textColor = Colors.textSecondary
        return label
    }
}
