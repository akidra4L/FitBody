import UIKit
import SnapKit

final class MealAddButton: UIControl {
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 40)
    }

    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else {
                return
            }

            iconImageView.image = isSelected
                ? UIImage(systemName: "checkmark.circle.fill")
                : UIImage(systemName: "poweroff")
        }
    }

    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = UILabel(with: Fonts.body2)

    let kind: Meal.Kind

    init(with kind: Meal.Kind) {
        self.kind = kind
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func configureColors() {
        backgroundColor = Colors.fillBackgroundPrimary
        titleLabel.textColor = Colors.textPrimary
    }

    private func setup() {
        [iconImageView, titleLabel].forEach { addSubview($0) }

        setupContent()
        setupConstraints()
        configureColors()
    }

    private func setupContent() {
        switch kind {
        case .breakfast:
            titleLabel.text = "Breakfast"
        case .lunch:
            titleLabel.text = "Lunch"
        case .snacks:
            titleLabel.text = "Snacks"
        case .dinner:
            titleLabel.text = "Dinner"
        }
    }

    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(
            image: UIImage(systemName: "poweroff")
        )
        imageView.tintColor = Colors.fillPrimary
        return imageView
    }
}
