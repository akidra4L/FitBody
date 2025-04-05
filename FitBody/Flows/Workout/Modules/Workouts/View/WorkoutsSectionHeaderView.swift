import UIKit
import SnapKit

final class WorkoutsSectionHeaderView: UITableViewHeaderFooterView {
    private lazy var titleLabel = makeTitleLabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func configure(with text: String) {
        titleLabel.text = text
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }

    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title5)
        label.textColor = Colors.textPrimary
        return label
    }
}
