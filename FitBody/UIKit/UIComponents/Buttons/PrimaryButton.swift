import UIKit

final class PrimaryButton: BaseButton {
    override public init(size: Size) {
        super.init(size: size)

        setup()
    }

    public func setSubtitle(_ subtitle: String?, for state: State) {
        subtitles[state.rawValue] = subtitle
    }

    private func setup() {
        backgroundColors = makeBackgroundColors()
        imageColors = makeImageColors()
        subtitleColors = makeSubtitleColors()
        titleColors = makeTitleColors()
    }

    private func makeBackgroundColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.fillPrimary,
            State.highlighted.rawValue: Colors.fillPrimaryPressed,
            State.disabled.rawValue: Colors.fillPrimaryDisabled
        ]
    }

    private func makeImageColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: .white,
            State.disabled.rawValue: Colors.textTertiary
        ]
    }

    private func makeSubtitleColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: Colors.buttonSecondary,
            State.disabled.rawValue: Colors.textTertiary
        ]
    }

    private func makeTitleColors() -> [State.RawValue: UIColor] {
        [
            State.normal.rawValue: .white,
            State.disabled.rawValue: Colors.textTertiary
        ]
    }
}
