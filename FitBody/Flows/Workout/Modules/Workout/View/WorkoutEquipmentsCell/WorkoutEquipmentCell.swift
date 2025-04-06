import UIKit
import SnapKit
import Kingfisher

final class WorkoutEquipmentCell: UICollectionViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var iconImageView = UIImageView()
    private lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with equipment: Workout.Equipment) {
        iconImageView.kf.setImage(with: equipment.icon)
        titleLabel.text = equipment.title
    }
    
    private func setup() {
        backgroundColor = .clear
        [containerView, titleLabel].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(120)
        }
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        view.addSubview(iconImageView)
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.textColor = Colors.textPrimary
        return label
    }
}
