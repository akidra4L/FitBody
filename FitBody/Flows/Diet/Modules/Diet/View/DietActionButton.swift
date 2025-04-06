import UIKit
import SnapKit

final class DietActionButton: UIControl {
    private lazy var iconImageView = makeIconImageView()
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else {
                return
            }
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.transform = (self?.isHighlighted == true) ? .init(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        addSubview(iconImageView)
        backgroundColor = Colors.fillPrimary
        layer.cornerRadius = 30
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.tintColor = Colors.fillInput
        return imageView
    }
}
