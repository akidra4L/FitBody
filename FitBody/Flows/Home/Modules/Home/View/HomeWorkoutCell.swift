import UIKit
import SnapKit
import Kingfisher

final class HomeWorkoutCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var illustrationImageView = UIImageView(image: Illustrations.homeWorkoutIllustration)
    private lazy var stackView = makeStackView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    
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
        illustrationImageView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(50)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(illustrationImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [illustrationImageView, stackView].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel, subtitleLabel]
        )
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title3)
        label.text = "Workout"
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.text = "Follow the training exercises"
        label.textColor = Colors.textSecondary
        return label
    }
}
