import UIKit
import SnapKit

final class GendersControl: UIControl {
    private(set) var selectedButton: GenderButton? {
        didSet {
            oldValue?.isSelected = false
            selectedButton?.isSelected = true
        }
    }

    private lazy var stackView = makeGenderButtonsStackView()
    private var genders: [GenderButton.Gender] = [.woman, .man]

    init() {
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    @objc
    private func genderButtonDidTap(_ button: GenderButton) {
        guard !button.isSelected else {
            return
        }

        selectedButton = button
        sendActions(for: .valueChanged)
    }

    func setSelected(_ gender: GenderButton.Gender?) {
        guard let gender else {
            selectedButton = nil
            return
        }

        selectedButton = stackView.arrangedSubviews
            .compactMap { $0 as? GenderButton }
            .first { $0.gender == gender }
    }

    private func setup() {
        addSubview(stackView)
        setupConstraints()
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }

    private func makeGenderButtonsStackView() -> UIStackView {
        let genderButtons: [GenderButton] = genders.enumerated().map { index, gender in
            let button = GenderButton(gender: gender)
            button.addTarget(self, action: #selector(genderButtonDidTap), for: .touchUpInside)
            return button
        }

        let view = UIStackView(arrangedSubviews: genderButtons)
        view.axis = .vertical
        return view
    }
}
