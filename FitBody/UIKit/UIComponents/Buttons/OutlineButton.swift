import UIKit

@MainActor
open class OutlineButton: BaseButton {
    override public init(size: Size) {
        super.init(size: size)

        setup()
    }

    public func setBackgroundColor(_ color: UIColor, for state: State) {
        backgroundColors[state.rawValue] = color
    }

    private func setup() {
        activityIndicatorView.color = Colors.fillPrimary
        backgroundColors = makeBackgroundColors()
        imageColors = makeImageColors()
        strokeColors = makeStrokeColors()
        strokeWidths = makeStrokeWidths()
        titleColors = makeTitleColors()
    }

    private func makeBackgroundColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillBackgroundPrimary,
            State.highlighted.rawValue: Colors.fillBackgroundSecondary,
            State.disabled.rawValue: Colors.fillBackgroundSecondary
        ]
    }

    private func makeImageColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillPrimary,
            State.highlighted.rawValue: Colors.fillPrimaryPressed,
            State.disabled.rawValue: Colors.buttonSecondary
        ]
    }

    private func makeStrokeColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillStroke,
            State.highlighted.rawValue: Colors.fillPrimaryPressed,
            State.selected.rawValue: Colors.fillPrimaryPressed
        ]
    }

    private func makeStrokeWidths() -> [State.RawValue: CGFloat] {
        [
            State.normal.rawValue: 0.5,
            State.disabled.rawValue: 0
        ]
    }

    private func makeTitleColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillPrimary,
            State.selected.rawValue: Colors.fillPrimaryPressed,
            State.disabled.rawValue: Colors.buttonSecondary
        ]
    }
}
