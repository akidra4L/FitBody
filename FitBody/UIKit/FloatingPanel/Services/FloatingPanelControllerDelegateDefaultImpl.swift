import CoreGraphics
import FloatingPanel

final class FloatingPanelControllerDelegateDefaultImpl: FloatingPanelControllerDelegate {
    var floatingPanelDidRemove: ((FloatingPanelController) -> Void)?

    init() {}

    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        floatingPanelDidRemove?(fpc)
    }

    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let heightForFull = fpc.surfaceLocation(for: .full)

        if fpc.surfaceLocation.y < heightForFull.y {
            fpc.surfaceLocation = heightForFull
        }
    }

    func floatingPanel(
        _ fpc: FloatingPanelController,
        shouldRemoveAt location: CGPoint,
        with velocity: CGVector
    ) -> Bool {
        velocity.dy >= 3.5
    }
}
