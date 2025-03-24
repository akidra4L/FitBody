import UIKit
import SnapKit

// MARK: - DoctorHospitalCellDelegate

protocol DoctorHospitalCellDelegate: AnyObject {
    func didTapContainerView(in cell: DoctorHospitalCell)
}

// MARK: - DoctorHospitalCell

final class DoctorHospitalCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var ratingView = RatingView()
    private lazy var iconImageView = makeIconImageView()
    private lazy var addressView = AddressView()
    
    weak var delegate: DoctorHospitalCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.containerView.transform = highlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
        }
    }
    
    @objc
    private func containerViewDidTap() {
        delegate?.didTapContainerView(in: self)
    }
    
    func configure(with viewModel: DoctorHospitalViewModel) {
        ratingView.configure(with: viewModel.ratingViewModel)
        titleLabel.text = viewModel.title
        addressView.configure(with: viewModel.address)
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
            )
        }
        ratingView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().offset(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
        }
        addressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
            make.bottom.equalToSuperview().offset(-16)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(
                CGSize(width: 8, height: 16)
            )
        }
    }
    
    private func makeContainerView() -> UIView {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(containerViewDidTap)
        )
        
        let view = UIView()
        [
            ratingView,
            titleLabel,
            iconImageView,
            addressView
        ].forEach { view.addSubview($0) }
        view.addGestureRecognizer(gestureRecognizer)
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline1)
        label.numberOfLines = 2
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: Icons.chevronRight)
        imageView.tintColor = Colors.iconPrimary
        return imageView
    }
}


