import UIKit
import SnapKit

final class GenderButton: UIControl {
    enum Gender: CaseIterable {
        case woman
        case man
    }

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
    private lazy var genderLabel = UILabel(with: Fonts.body2)

    let gender: Gender

    init(gender: Gender) {
        self.gender = gender
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func configureColors() {
        backgroundColor = Colors.fillBackgroundPrimary
        genderLabel.textColor = Colors.textPrimary
    }

    private func setup() {
        [iconImageView, genderLabel].forEach { addSubview($0) }
        setupContent()
        setupConstraints()
        configureColors()
    }

    private func setupContent() {
        switch gender {
        case .man:
            genderLabel.text = "Man"
        case .woman:
            genderLabel.text = "Woman"
        }
    }

    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        genderLabel.snp.makeConstraints { make in
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
