import FloatingPanel
import UIKit

// MARK: - FloatingPanelAttributes

public struct FloatingPanelAttributes {
    let layout: FloatingPanelLayout
    let contentMode: FloatingPanelController.ContentMode
    let isEnabledDismissalTapGesture: Bool
    let isSwipable: Bool

    var isRemovalInteractionEnabled: Bool {
        isSwipable
    }

    public init(
        with kind: Kind,
        contentMode: FloatingPanelController.ContentMode = .static,
        isEnabledDismissalTapGesture: Bool = true,
        isSwipable: Bool = true,
        backdropAlpha: CGFloat = 0.8
    ) {
        self.layout =
            switch kind {
            case let .adaptive(contentLayout):
                AdaptiveFloatingPanelLayout(with: contentLayout, and: backdropAlpha)
            }
        self.contentMode = contentMode
        self.isEnabledDismissalTapGesture = isEnabledDismissalTapGesture
        self.isSwipable = isSwipable
    }
}

// MARK: - FloatingPanelAttributes.Kind

extension FloatingPanelAttributes {
    public enum Kind {
        case adaptive(contentLayout: UILayoutGuide)
    }
}
