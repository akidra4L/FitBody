import UIKit
import SnapKit

final class DietTopCell: UITableViewCell {
    private lazy var illustrationImageView = UIImageView(image: Illustrations.dietGraphIllustration)
    
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
        contentView.addSubview(illustrationImageView)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
