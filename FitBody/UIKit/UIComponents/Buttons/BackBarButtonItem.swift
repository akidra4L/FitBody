import UIKit

public final class BackBarButtonItem: UIBarButtonItem {
    override public var menu: UIMenu? {
        get { super.menu }
        set {}
    }

    override public init() {
        super.init()

        self.title = ""
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}
