import UIKit
import SnapKit

final class UserProfileSetContentView: UIView {
    var selectedGender: Gender? {
        genderView.selectedGender
    }
    
    var selectedBirthDate: Date {
        birthDateView.selectedBirthDate
    }
    
    var weight: Double? {
        guard let value = weightParameterView.value else {
            return nil
        }
        
        return Double(value)
    }
    
    var height: Double? {
        guard let value = heightParameterView.value else {
            return nil
        }
        
        return Double(value)
    }
    
    private lazy var illustrationImageView = UIImageView(image: Illustrations.userProfileSetIllustration)
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    private lazy var verticalStackView = makeVerticalStackView()
    private lazy var genderView = UserProfileSetGenderView()
    private lazy var birthDateView = UserProfileSetBirthDateView()
    private lazy var weightParameterView = UserProfileSetParametersView(placeholder: "Your Weight", parameter: "KG")
    private lazy var heightParameterView = UserProfileSetParametersView(placeholder: "Your Height", parameter: "CM")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureErrorVisibility() {
        birthDateView.configureErrorVisibility()
        weightParameterView.configureErrorVisibility()
        heightParameterView.configureErrorVisibility()
    }
    
    private func setup() {
        [
            illustrationImageView,
            titleLabel,
            subtitleLabel,
            verticalStackView
        ].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title1)
        label.text = "Let's complete your profile"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.text = "It will help us to know more about you!"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeVerticalStackView() -> UIStackView {
        let stackView = UIStackView(
            arrangedSubviews: [
                genderView,
                birthDateView,
                weightParameterView,
                heightParameterView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }
}
