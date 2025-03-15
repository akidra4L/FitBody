import UIKit
import SnapKit

// MARK: - UserProfileSetParametersView

final class UserProfileSetParametersView: UIView {
    var value: String? {
        textField.text
    }
    
    private lazy var textField = makeTextField()
    private lazy var parameterView = ParameterView(with: parameter)
    
    private let placeholder: String
    private let parameter: String
    
    init(placeholder: String, parameter: String) {
        self.placeholder = placeholder
        self.parameter = parameter
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureErrorVisibility() {
        textField.hasError = (textField.text?.nilIfEmpty == nil)
    }
    
    private func setup() {
        [textField, parameterView].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
        }
        parameterView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.size.equalTo(48)
        }
    }
    
    private func makeTextField() -> BaseTextField {
        let textField = BaseTextField(size: .medium)
        textField.keyboardType = .numberPad
        textField.placeholder = placeholder
        return textField
    }
}

// MARK: - UserProfileSetParametersView.ParameterView

extension UserProfileSetParametersView {
    fileprivate final class ParameterView: UIView {
        private lazy var gradientView = GradientView()
        private lazy var titleLabel = makeTitleLabel()
        
        private let parameter: String
        
        init(with parameter: String) {
            self.parameter = parameter
            super.init(frame: .zero)
            
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
        
        private func setup() {
            [gradientView, titleLabel].forEach { addSubview($0) }
            clipsToBounds = true
            layer.cornerRadius = 12
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            gradientView.snp.makeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
            titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        private func makeTitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.headline1)
            label.text = parameter
            label.textColor = .white
            return label
        }
    }
}

// MARK: - UserProfileSetParametersView.ParameterView.GradientView

extension UserProfileSetParametersView.ParameterView {
    fileprivate final class GradientView: UIView {
        private lazy var gradientLayer = makeGradientLayer()

        override init(frame: CGRect) {
            super.init(frame: frame)

            layer.addSublayer(gradientLayer)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }

        override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)

            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientLayer.frame = layer.bounds
            CATransaction.commit()
        }

        private func makeGradientLayer() -> CAGradientLayer {
            let layer = CAGradientLayer()
            layer.colors = [
                UIColor(hex: "#EEA4CE")?.cgColor,
                UIColor(hex: "#C58BF2")?.cgColor
            ].compactMap(\.self)
            layer.endPoint = CGPoint(x: 1, y: 0.5)
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            return layer
        }
    }
}
