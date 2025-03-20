import UIKit
import SnapKit

final class ReviewView: UIView {
    private lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with review: String) {
        titleLabel.text = review
    }
    
    private func setup() {
        addSubview(titleLabel)
        backgroundColor = Colors.fillBackgroundSecondary
        layer.cornerRadius = 12
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
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
