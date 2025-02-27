import FloatingPanel
import UIKit

final class FloatingPanelControllerFactory {
    typealias Attributes = FloatingPanelAttributes
    typealias Delegate = FloatingPanelControllerDelegate

    init() {}

    func make(with attributes: Attributes, and delegate: Delegate?) -> FloatingPanelController {
        let controller = FloatingPanelController(delegate: delegate)
        controller.backdropView.dismissalTapGestureRecognizer.isEnabled = attributes.isEnabledDismissalTapGesture
        controller.contentInsetAdjustmentBehavior = .never
        controller.contentMode = attributes.contentMode
        controller.isRemovalInteractionEnabled = attributes.isRemovalInteractionEnabled
        controller.layout = attributes.layout
        controller.panGestureRecognizer.isEnabled = attributes.isSwipable
        controller.surfaceView.grabberHandle.isHidden = true
        controller.surfaceView.appearance = makeSurfaceAppearance()
        return controller
    }

    private func makeSurfaceAppearance() -> SurfaceAppearance {
        let appearance = SurfaceAppearance()
        appearance.backgroundColor = .clear
        appearance.cornerRadius = 12
        return appearance
    }
}
