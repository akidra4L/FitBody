import UIKit
import SnapKit

final class HomeWaterIntakeCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var iconImageView = UIImageView(image: Icons.plusFillIcon24x24)
    private lazy var waterView = WaterView()
    
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
    
    func configure(with viewModel: HomeWaterIntakeViewModel) {
        titleLabel.text = viewModel.title
        waterView.configure(with: viewModel.waterIntakeText)
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
                UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
            )
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(24)
        }
        waterView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            titleLabel,
            iconImageView,
            waterView
        ].forEach { view.addSubview($0) }
        view.backgroundColor = UIColor(hex: "#9DCEFF")?.withAlphaComponent(0.9)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title4)
        label.numberOfLines = 2
        label.textColor = Colors.fillInput
        return label
    }
}

// MARK: - HomeWaterIntakeCell.WaterView

extension HomeWaterIntakeCell {
    private final class WaterView: UIView {
        private lazy var iconImageView = UIImageView(image: Icons.waterGlass25x35)
        private lazy var titleLabel = makeTitleLabel()
        private lazy var subtitleLabel = makeSubtitleLabel()
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
        
        func configure(with title: String) {
            titleLabel.text = title
        }
        
        private func setup() {
            [iconImageView, titleLabel, subtitleLabel].forEach { addSubview($0) }
            backgroundColor = Colors.fillInput
            layer.cornerRadius = 12
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            iconImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(16)
                make.size.equalTo(
                    CGSize(width: 25, height: 35)
                )
            }
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.leading.equalTo(iconImageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
            subtitleLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.leading.equalTo(iconImageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-12)
            }
        }
        
        private func makeTitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.body2)
            label.textColor = UIColor(hex: "#92A3FD")
            return label
        }
        
        private func makeSubtitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.headline5)
            label.text = "Water Intake"
            label.textColor = Colors.textSecondary
            return label
        }
    }
}
