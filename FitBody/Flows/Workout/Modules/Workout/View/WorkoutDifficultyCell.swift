import UIKit
import SnapKit

final class WorkoutDifficultyCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var difficultyLabel = makeDifficultyLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with difficulty: String) {
        difficultyLabel.text = difficulty
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
                UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
            )
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(16)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(difficultyLabel.snp.leading).offset(-8)
        }
        difficultyLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            iconImageView,
            titleLabel,
            difficultyLabel
        ].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body2)
        label.text = "Difficulty"
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeDifficultyLabel() -> UILabel {
        let label = UILabel(with: Fonts.body2)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(
            image: UIImage(systemName: "arrow.up.arrow.down")
        )
        imageView.tintColor = Colors.iconSecondary
        return imageView
    }
}
