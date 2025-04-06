import UIKit
import SnapKit

final class DietSectionHeaderView: UITableViewHeaderFooterView {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func configure(with text: String, and subtitle: String? = nil) {
        titleLabel.text = text
        subtitleLabel.text = subtitle
    }

    private func setup() {
        [titleLabel, subtitleLabel].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(subtitleLabel.snp.leading).offset(-8)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title5)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = Colors.textSecondary
        return label
    }
}
