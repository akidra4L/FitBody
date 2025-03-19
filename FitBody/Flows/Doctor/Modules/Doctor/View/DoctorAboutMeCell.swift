import UIKit
import SnapKit

final class DoctorAboutMeCell: UITableViewCell {
    private lazy var titleLabel = makeTitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
            )
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.numberOfLines = 0
        label.textColor = Colors.textSecondary
        return label
    }
}
