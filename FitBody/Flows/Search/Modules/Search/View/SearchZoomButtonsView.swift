import UIKit
import SnapKit

// MARK: - SearchZoomButtonsViewDelegate

protocol SearchZoomButtonsViewDelegate: AnyObject {
    func searchZoomButtonsView(
        _ view: SearchZoomButtonsView,
        didTapButtonWithKind kind: SearchZoomButtonsView.ZoomButton.ZoomKind
    )
}

// MARK: - SearchZoomButtonsView

final class SearchZoomButtonsView: UIStackView {
    typealias Delegate = SearchZoomButtonsViewDelegate
    
    private weak var delegate: Delegate?

    init(with delegate: Delegate?) {
        self.delegate = delegate
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func zoomPlusButtonDidTap() {
        delegate?.searchZoomButtonsView(self, didTapButtonWithKind: .plus)
    }

    @objc
    private func zoomMinusButtonDidTap() {
        delegate?.searchZoomButtonsView(self, didTapButtonWithKind: .minus)
    }

    private func setup() {
        [
            makeZoomButton(with: .plus),
            makeZoomButton(with: .minus)
        ].forEach { addArrangedSubview($0) }
        axis = .vertical
    }

    private func makeZoomButton(with kind: ZoomButton.ZoomKind) -> UIButton {
        let button = ZoomButton(kind: kind)
        button.addTarget(
            self,
            action: kind == .plus ? #selector(zoomPlusButtonDidTap) : #selector(zoomMinusButtonDidTap),
            for: .touchUpInside
        )
        return button
    }
}

// MARK: - SearchZoomButtonsView.ZoomButton

extension SearchZoomButtonsView {
    final class ZoomButton: UIButton {
        enum ZoomKind {
            case plus
            case minus
        }

        override var isHighlighted: Bool {
            didSet {
                guard oldValue != isHighlighted else {
                    return
                }

                backgroundColor = isHighlighted ? Colors.fillBackgroundSecondary : Colors.fillBackgroundPrimary
            }
        }

        private let kind: ZoomKind

        init(kind: ZoomKind) {
            self.kind = kind
            super.init(frame: .zero)

            setup()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }

        private func setup() {
            contentEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
            layer.borderColor = Colors.fillStroke.cgColor
            layer.borderWidth = 0.5
            layer.cornerRadius = 16
            layer.maskedCorners = kind == .plus
                ? [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                : [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            setImage(
                kind == .plus ? UIImage(systemName: "plus") : UIImage(systemName: "minus"),
                for: .normal
            )

            backgroundColor = isHighlighted ? Colors.fillBackgroundSecondary : Colors.fillBackgroundPrimary
            tintColor = Colors.iconSecondary
        }
    }
}
