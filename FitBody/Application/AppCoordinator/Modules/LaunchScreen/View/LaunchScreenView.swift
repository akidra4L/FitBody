import UIKit
import SnapKit

final class LaunchScreenView: UIView {
    private lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        addSubview(titleLabel)
        backgroundColor = Colors.fillPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "FitBody"
        label.textColor = Colors.fillInput
        return label
    }
}
