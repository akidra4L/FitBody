import UIKit
import SnapKit

final class AddressView: UIView {
    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with address: String) {
        titleLabel.text = address
    }
    
    private func setup() {
        [iconImageView, titleLabel].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
        }
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: Icons.address16x16)
        imageView.tintColor = Colors.iconSecondary
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.numberOfLines = 2
        label.textColor = Colors.textSecondary
        return label
    }
}
