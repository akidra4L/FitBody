import UIKit
import SnapKit

final class UserProfileQuitCell: UITableViewCell {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var iconImageView = makeIconImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        backgroundColor = .clear
        [titleLabel, iconImageView].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(16)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.size.equalTo(
                CGSize(width: 8, height: 16)
            )
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title3)
        label.text = "Quit"
        label.textColor = Colors.textError
        return label
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: Icons.chevronRight)
        imageView.tintColor = Colors.textError
        return imageView
    }
}
