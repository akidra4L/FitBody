import UIKit

final class TextButton: BaseButton {
    override public init(size: Size) {
        super.init(size: size)

        setup()
    }

    private func setup() {
        activityIndicatorView.color = Colors.fillPrimary
        imageColors = makeImageColors()
        titleColors = makeTitleColors()
    }

    private func makeImageColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillPrimary,
            State.highlighted.rawValue: Colors.fillPrimaryPressed,
            State.disabled.rawValue: Colors.fillPrimaryDisabled
        ]
    }

    private func makeTitleColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillPrimary,
            State.highlighted.rawValue: Colors.fillPrimaryPressed,
            State.disabled.rawValue: Colors.textTertiary
        ]
    }
}
