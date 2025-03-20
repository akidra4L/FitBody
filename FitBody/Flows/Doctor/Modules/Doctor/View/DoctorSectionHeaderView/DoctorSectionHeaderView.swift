import UIKit
import SnapKit

// MARK: - DoctorSectionHeaderViewDelegate

protocol DoctorSectionHeaderViewDelegate: AnyObject {
    func didTapActionButton(in view: DoctorSectionHeaderView)
}

// MARK: - DoctorSectionHeaderView

final class DoctorSectionHeaderView: UITableViewHeaderFooterView {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var actionButton = makeActionButton()
    
    weak var delegate: DoctorSectionHeaderViewDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }

    func configure(with viewModel: DoctorSectionHeaderViewModel) {
        titleLabel.text = viewModel.title
        actionButton.isHidden = viewModel.isHiddenButton
    }

    private func setup() {
        [titleLabel, actionButton].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(actionButton.snp.leading).offset(-12)
        }
        actionButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeActionButton() -> BaseButton {
        let button = TextButton(size: .medium)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.isActiveChevron = true
        button.setTitle("More", for: .normal)
        return button
    }
}
