import UIKit

open class BaseTextField: UITextField {
    override public var intrinsicContentSize: CGSize {
        makeIntrinsicSize(for: size)
    }

    override open var isEnabled: Bool {
        didSet {
            guard oldValue != isEnabled else {
                return
            }

            layer.opacity = isEnabled ? 1 : 0.5
        }
    }

    override public var placeholder: String? {
        didSet {
            guard oldValue != placeholder else {
                return
            }

            configurePlaceholder()
        }
    }

    public var hasError = false {
        didSet {
            guard oldValue != hasError else {
                return
            }

            configureBackgroundColor()
            configureBorder()
        }
    }

    private let size: Size

    init(size: Size) {
        self.size = size
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        nil
    }

    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            origin: .zero,
            size: CGSize(width: 16, height: bounds.height)
        )
    }

    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            origin: CGPoint(x: bounds.width - 16, y: 0),
            size: CGSize(width: 16, height: bounds.height)
        )
    }

    @objc
    open func baseTextFieldEditingDidBegin() {
        configureBackgroundColor()
        configureBorder()
    }

    @objc
    open func baseTextFieldEditingDidEnd() {
        configureBackgroundColor()
        configureBorder()
    }

    private func configureBackgroundColor() {
        guard !hasError else {
            backgroundColor = Colors.fillInput
            return
        }

        backgroundColor = isEditing ? Colors.fillInput.withAlphaComponent(0.7) : Colors.fillInput
    }

    private func configureBorder() {
        configureBorderColor()

        guard !hasError else {
            layer.borderWidth = 1
            return
        }

        layer.borderWidth = isEditing ? 1 : 0.5
    }

    private func configureBorderColor() {
        guard !hasError else {
            layer.borderColor = UIColor.red.cgColor
            return
        }

        layer.borderColor = isEditing ? Colors.fillStrokePressed.cgColor : Colors.fillStroke.cgColor
    }

    private func configurePlaceholder() {
        if let placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .font: Fonts.body3,
                    .foregroundColor: Colors.textTertiary
                ]
            )
        } else {
            attributedPlaceholder = nil
        }
    }

    private func setup() {
        addTarget(self, action: #selector(baseTextFieldEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(baseTextFieldEditingDidEnd), for: .editingDidEnd)
        clipsToBounds = true
        font = Fonts.body1
        layer.cornerRadius = 12
        leftView = UIView()
        leftViewMode = .always
        rightView = UIView()
        rightViewMode = .always
        textAlignment = .left
        textColor = Colors.textPrimary
        tintColor = Colors.textSecondary

        configureBackgroundColor()
        configureBorder()
        configurePlaceholder()
    }

    private func makeIntrinsicSize(for size: Size) -> CGSize {
        switch size {
        case .medium:
            CGSize(width: super.intrinsicContentSize.width, height: 48)
        case .large:
            CGSize(width: super.intrinsicContentSize.width, height: 56)
        }
    }
}

extension BaseTextField {
    enum Size {
        case medium
        case large
    }
}
