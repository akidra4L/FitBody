import UIKit
import SnapKit
import Kingfisher

final class GoalCell: UICollectionViewCell {
    typealias Goal = RegisterRequest.Goal
    
    private lazy var containerView = makeContainerView()
    private lazy var illustrationImageView = UIImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    
    var goal: Goal?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: GoalCellViewModel) {
        self.goal = viewModel.goal
        illustrationImageView.image = viewModel.illustration
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        illustrationImageView.snp.updateConstraints { make in
            make.height.equalTo(viewModel.illustrationHeight)
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        contentView.backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        illustrationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(0)
        }
        titleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            illustrationImageView,
            titleLabel,
            descriptionLabel
        ].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillPrimary
        view.layer.cornerRadius = 20
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title1)
        label.textAlignment = .center
        label.textColor = Colors.fillInput
        return label
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Colors.fillInput
        return label
    }
}
