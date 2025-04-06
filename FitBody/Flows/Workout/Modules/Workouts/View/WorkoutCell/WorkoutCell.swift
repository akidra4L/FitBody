import UIKit
import SnapKit

final class WorkoutCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    private lazy var actionButton = makeActionButton()
    private lazy var illustrationBackgroundView = makeIllustrationBackgroundView()
    private lazy var illustrationImageView = UIImageView()
    
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
    
    func configure(with viewModel: WorkoutCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        illustrationImageView.image = viewModel.illustration
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
                UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            )
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.lessThanOrEqualTo(actionButton.snp.top).offset(-12)
        }
        actionButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        illustrationBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(92)
        }
        illustrationImageView.snp.makeConstraints { make in
            make.center.equalTo(illustrationBackgroundView)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            titleLabel,
            subtitleLabel,
            actionButton,
            illustrationBackgroundView,
            illustrationImageView
        ].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title6)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline5)
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeActionButton() -> UIButton {
        let button = OutlineButton(size: .small)
        button.isUserInteractionEnabled = false
        button.setTitle("View more", for: .normal)
        return button
    }
    
    private func makeIllustrationBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.fillInput
        view.layer.cornerRadius = 46
        return view
    }
}
