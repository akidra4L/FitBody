import UIKit

final class DividerView: UIView {
    override public var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 0.5)
    }

    init() {
        super.init(frame: .zero)

        backgroundColor = Colors.fillStroke
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}
