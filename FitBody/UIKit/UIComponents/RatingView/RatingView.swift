import UIKit
import SnapKit

final class RatingView: UIStackView {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var iconImageView = makeIconImageView()

    public init() {
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with viewModel: RatingViewModel) {
        titleLabel.text = viewModel.title
    }

    private func setup() {
        [titleLabel, iconImageView].forEach { addArrangedSubview($0) }
        alignment = .center
        spacing = 4

        setupConstraints()
    }

    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(12)
        }
    }

    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title6)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = UIColor(hex: "#FFD33C")
        return imageView
    }
}
