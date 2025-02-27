import UIKit

final class PhoneNumberTextField: BaseTextField {
    typealias Size = BaseTextField.Size

    override init(size: Size) {
        super.init(size: size)

        setup()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

    private func setup() {
        keyboardType = .numberPad
        placeholder = "Номер телефона"
        textContentType = .telephoneNumber
    }
}
