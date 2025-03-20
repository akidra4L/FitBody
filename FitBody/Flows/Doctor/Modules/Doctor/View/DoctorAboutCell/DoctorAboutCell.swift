import UIKit
import SnapKit

// MARK: - DoctorAboutMeCellDelegate

protocol DoctorAboutCellDelegate: AnyObject {
    func didTapActionButton(in cell: DoctorAboutCell)
}

// MARK: - DoctorAboutCell

final class DoctorAboutCell: UITableViewCell {
    weak var delegate: DoctorAboutCellDelegate?
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var actionButton = makeActionButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: DoctorAboutCellViewModel) {
        titleLabel.numberOfLines = viewModel.numberOfLines
        titleLabel.text = viewModel.description
        actionButton.setImage(viewModel.buttonImage)
        actionButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }
    
    private func setup() {
        backgroundColor = .clear
        [titleLabel, actionButton].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeActionButton() -> TextButton {
        let button = TextButton(size: .small)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        return button
    }
}
