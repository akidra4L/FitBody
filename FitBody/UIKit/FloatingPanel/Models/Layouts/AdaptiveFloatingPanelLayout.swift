import FloatingPanel
import UIKit

// MARK: - AdaptiveFloatingPanelLayout

final class AdaptiveFloatingPanelLayout {
    private let contentLayout: UILayoutGuide
    private let backdropAlpha: CGFloat

    init(with contentLayout: UILayoutGuide, and backdropAlpha: CGFloat) {
        self.contentLayout = contentLayout
        self.backdropAlpha = backdropAlpha
    }
}

// MARK: - FloatingPanelLayout

extension AdaptiveFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition { .bottom }

    var initialState: FloatingPanelState { .full }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        [
            .full: FloatingPanelAdaptiveLayoutAnchor(
                fractionalOffset: 0,
                contentLayout: contentLayout,
                referenceGuide: .superview
            )
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        backdropAlpha
    }
}
