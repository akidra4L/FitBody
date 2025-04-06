import UIKit
import SnapKit

// MARK: - MealAddViewDelegate

protocol MealAddViewDelegate: AnyObject {
    func didTapActionButton(in view: MealAddView)
}

// MARK: - MealAddView

final class MealAddView: UIView {
    typealias Delegate = MealAddViewDelegate
    
    var kind: Meal.Kind? {
        kindButton.selectedButton?.kind
    }
    
    var name: String? {
        textField.text?.nilIfEmpty
    }
    
    private lazy var kindButton = MealAddKindButton()
    private lazy var textField = makeTextField()
    private lazy var actionButton = makeActionButton()
    
    private weak var delegate: Delegate?
    
    init(with delegate: Delegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }
    
    func configureErrorState() {
        textField.hasError = true
    }
    
    private func setup() {
        [
            kindButton,
            textField,
            actionButton
        ].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        kindButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(kindButton.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeTextField() -> BaseTextField {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "Enter a meal name"
        return textField
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        return button
    }
}
