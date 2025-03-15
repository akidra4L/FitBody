import UIKit
import SnapKit

final class UserProfileSetGenderView: UIView {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var gendersControl = GendersControl()
    
    var selectedGender: Gender? {
        switch gendersControl.selectedButton?.gender {
        case .man:
            .man
        case .woman:
            .woman
        default:
            nil
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
        [titleLabel, gendersControl].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        gendersControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.text = "Choose Gender"
        label.textColor = Colors.textPrimary
        return label
    }
}
