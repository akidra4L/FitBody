import UIKit
import SnapKit
import Resolver

// MARK: - UserProfileSetBirthDateView

final class UserProfileSetBirthDateView: UIView {
    private lazy var titleLabel = makeTitleLabel()
    private lazy var dateTextField = DateTextField()
    
    var selectedBirthDate: Date {
        dateTextField.birthDatePicker.date
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureErrorVisibility() {
        dateTextField.hasError = (dateTextField.text?.nilIfEmpty == nil)
    }
    
    private func setup() {
        [titleLabel, dateTextField].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.text = "Date of Birth"
        label.textColor = Colors.textPrimary
        return label
    }
}

// MARK: - DateTextField

extension UserProfileSetBirthDateView {
    final class DateTextField: BaseTextField {
        lazy var birthDatePicker = makeBirthDatePicker()

        @Injected private var dateFormatter: PropertyDateFormatter

        init() {
            super.init(size: .medium)

            setup()
        }

        @objc
        private func updateTextIfNeeded() {
            let formattedDateText = dateFormatter.string(
                from: birthDatePicker.date,
                withFormat: "dd/MM/yyyy"
            )

            text = formattedDateText
            sendActions(for: .editingChanged)
        }

        func updateBirthDate(_ date: Date?) {
            guard let date else {
                return
            }

            birthDatePicker.date = date
            text = dateFormatter.string(
                from: date,
                withFormat: "dd/MM/yyyy"
            )
        }

        private func configureColors() {
            rightView?.tintColor = Colors.iconSecondary
        }

        private func setup() {
            addTarget(self, action: #selector(updateTextIfNeeded), for: .editingDidBegin)
            inputView = birthDatePicker
            placeholder = "dd/mm/yyyy"

            configureColors()
        }

        private func makeBirthDatePicker() -> UIDatePicker {
            let datePicker = UIDatePicker()
            datePicker.addTarget(self, action: #selector(updateTextIfNeeded), for: .valueChanged)
            datePicker.calendar = Calendar(identifier: .gregorian)
            datePicker.date = .makeUsingDateComponents(year: 1998) ?? Date()
            datePicker.datePickerMode = .date
            datePicker.maximumDate = Date()
            datePicker.minimumDate = .makeUsingDateComponents(year: 1950)
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.timeZone = .utc
            return datePicker
        }
    }
}
