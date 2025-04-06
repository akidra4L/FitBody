import UIKit
import SnapKit

final class MealAddKindButton: UIControl {
    private(set) var selectedButton: MealAddButton? {
        didSet {
            oldValue?.isSelected = false
            selectedButton?.isSelected = true
        }
    }

    private lazy var stackView = makeMealAddButtonsStackView()
    private var kinds = Meal.Kind.allCases

    init() {
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    @objc
    private func genderButtonDidTap(_ button: MealAddButton) {
        guard !button.isSelected else {
            return
        }

        selectedButton = button
        sendActions(for: .valueChanged)
    }

    func setSelected(_ kind: Meal.Kind?) {
        guard let kind else {
            selectedButton = nil
            return
        }

        selectedButton = stackView.arrangedSubviews
            .compactMap { $0 as? MealAddButton }
            .first { $0.kind == kind }
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

    private func makeMealAddButtonsStackView() -> UIStackView {
        let buttons = Meal.Kind.allCases.map { kind in
            let button = MealAddButton(with: kind)
            button.addTarget(self, action: #selector(genderButtonDidTap), for: .touchUpInside)
            return button
        }

        let view = UIStackView(arrangedSubviews: buttons)
        view.axis = .vertical
        return view
    }
}
