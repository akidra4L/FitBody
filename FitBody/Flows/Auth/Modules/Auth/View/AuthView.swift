import UIKit
import SnapKit

// MARK: - AuthViewDelegate

protocol AuthViewDelegate: AnyObject {
    func didTapPrimaryButton(in view: AuthView)
    func didTapSecondaryButton(in view: AuthView)
}

// MARK: - AuthView

final class AuthView: UIView {
    typealias State = AuthState
    typealias Delegate = AuthViewDelegate
    
    var firstName: String? {
        firstNameTextFieldView.text?.nilIfEmpty
    }
    
    var lastName: String? {
        lastNameTextFieldView.text?.nilIfEmpty
    }
    
    var email: String? {
        emailTextFieldView.text?.nilIfEmpty
    }
    
    var password: String? {
        passwordTextFieldView.text?.nilIfEmpty
    }
    
    private lazy var scrollView = makeScrollView()
    private lazy var verticalStackView = makeVerticalStackView()
    private lazy var firstNameTextFieldView = TextFieldView(with: "First name", and: "Enter first name")
    private lazy var lastNameTextFieldView = TextFieldView(with: "Last name", and: "Enter last name")
    private lazy var emailTextFieldView = TextFieldView(with: "Email", and: "Enter email")
    private lazy var passwordTextFieldView = TextFieldView(with: "Password", and: "Enter password", isPassword: true)
    private lazy var bottomView = makeBottomView()
    private lazy var primaryButton = makePrimaryButton()
    private lazy var secondaryButton = makeSecondaryButton()
    
    private let notificationCenter = NotificationCenter.default
    
    private var state: State
    private weak var delegate: Delegate?
    
    init(with state: State, and delegate: Delegate?) {
        self.state = state
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    private func primaryButtonDidTap() {
        delegate?.didTapPrimaryButton(in: self)
    }
    
    @objc
    private func secondaryButtonDidTap() {
        delegate?.didTapSecondaryButton(in: self)
    }
    
    @objc
    private func applicationStateDidChange(with notification: Notification) {
        let appearance = KeyboardAppearance(from: notification)
        let bottomOffset = (notification.name == UIResponder.keyboardWillShowNotification)
            ? -(appearance.endFrame.height - safeAreaInsets.bottom + 12)
            : -12

        UIView.animate(
            withDuration: appearance.animationDuration,
            delay: 0,
            options: appearance.animationOptions,
            animations: { [weak self] in
                guard let self else {
                    return
                }

                bottomView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.safeAreaLayoutGuide).offset(bottomOffset)
                }
                layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    func configure(with state: State) {
        self.state = state
        setContentVisible(isVisible: false) { [weak self] in
            self?.configureData(with: state)
            self?.setContentVisible(isVisible: true)
        }
    }
    
    func configureErrorVisibility() {
        firstNameTextFieldView.configureErrorVisibilityIfNeeded()
        lastNameTextFieldView.configureErrorVisibilityIfNeeded()
        emailTextFieldView.configureErrorVisibilityIfNeeded()
        passwordTextFieldView.configureErrorVisibilityIfNeeded()
    }
    
    private func configureData(with state: State) {
        [
            firstNameTextFieldView,
            lastNameTextFieldView,
            emailTextFieldView,
            passwordTextFieldView
        ].forEach { $0.setupInitialState() }
        
        let arrangedSubviews = state == .login
            ? [emailTextFieldView, passwordTextFieldView]
            : [firstNameTextFieldView, lastNameTextFieldView, emailTextFieldView, passwordTextFieldView]
        
        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        arrangedSubviews.forEach { verticalStackView.addArrangedSubview($0) }
        secondaryButton.setTitle(state == .login ? "Register" : "Login", for: .normal)
    }
    
    private func setContentVisible(isVisible: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self else {
                    return
                }

                verticalStackView.alpha = isVisible ? 1 : 0
            },
            completion: { _ in
                completion?()
            }
        )
    }
    
    private func setup() {
        [scrollView, bottomView].forEach { addSubview($0) }
        backgroundColor = Colors.fillInput
        
        setupConstraints()
        setupObservers()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(bottomView.snp.top).offset(-32)
        }
        verticalStackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        bottomView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func setupObservers() {
        notificationCenter.addObserver(
            self,
            selector: #selector(applicationStateDidChange),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(applicationStateDidChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.addSubview(verticalStackView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    private func makeVerticalStackView() -> UIStackView {
        let arrangedSubviews = state == .login
            ? [emailTextFieldView, passwordTextFieldView]
            : [firstNameTextFieldView, lastNameTextFieldView, emailTextFieldView, passwordTextFieldView]
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }
    
    private func makeBottomView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [primaryButton, secondaryButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }
    
    private func makePrimaryButton() -> LoadableButton {
        let button = PrimaryButton(size: .large)
        button.addTarget(self, action: #selector(primaryButtonDidTap), for: .touchUpInside)
        button.setTitle("Confirm", for: .normal)
        return button
    }
    
    private func makeSecondaryButton() -> UIButton {
        let button = OutlineButton(size: .large)
        button.addTarget(self, action: #selector(secondaryButtonDidTap), for: .touchUpInside)
        button.setTitle(state == .login ? "Register" : "Login", for: .normal)
        return button
    }
}

// MARK: - AuthView.TextFieldView

extension AuthView {
    fileprivate final class TextFieldView: UIView {
        var text: String? {
            textField.text
        }
        
        private lazy var titleLabel = makeTitleLabel()
        private lazy var textField = makeTextField()
        
        private let title: String
        private let placeholder: String
        private let isPassword: Bool
        
        init(with title: String, and placeholder: String, isPassword: Bool = false) {
            self.title = title
            self.placeholder = placeholder
            self.isPassword = isPassword
            super.init(frame: .zero)
            
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
        
        @objc
        private func togglePasswordVisibility(_ sender: UIButton) {
            guard let textField = sender.superview as? UITextField else {
                return
            }
            
            textField.isSecureTextEntry.toggle()
            
            let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
            sender.setImage(
                UIImage(systemName: imageName),
                for: .normal
            )
        }
        
        func configureErrorVisibilityIfNeeded() {
            textField.hasError = (text?.nilIfEmpty == nil)
        }
        
        func setupInitialState() {
            textField.hasError = false
        }
        
        private func setup() {
            [titleLabel, textField].forEach { addSubview($0) }
            backgroundColor = .clear
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.directionalHorizontalEdges.equalToSuperview()
            }
            textField.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.directionalHorizontalEdges.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        private func makeTitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.headline2)
            label.text = title
            label.textColor = Colors.textPrimary
            return label
        }
        
        private func makeTextField() -> BaseTextField {
            let textField = isPassword ? TextField(size: .medium) : BaseTextField(size: .medium)
            textField.placeholder = placeholder
            return textField
        }
    }
}

// MARK: - AuthView.TextFieldView.TextField

extension AuthView.TextFieldView {
    private final class TextField: BaseTextField {
        override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            CGRect(
                origin: CGPoint(x: bounds.width - 40, y: 0),
                size: CGSize(width: 40, height: bounds.height)
            )
        }
        
        override init(size: BaseTextField.Size) {
            super.init(size: size)
            
            setup()
        }
        
        @objc
        private func togglePasswordVisibility(_ sender: UIButton) {
            guard let textField = sender.superview as? UITextField else {
                return
            }
            
            textField.isSecureTextEntry.toggle()
            
            let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
            sender.setImage(
                UIImage(systemName: imageName),
                for: .normal
            )
        }
        
        private func setup() {
            let toggleButton = UIButton(type: .custom)
            toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            toggleButton.tintColor = Colors.fillPrimary
            
            isSecureTextEntry = true
            rightView = toggleButton
            rightViewMode = .always
            textContentType = .oneTimeCode
        }
    }
}
