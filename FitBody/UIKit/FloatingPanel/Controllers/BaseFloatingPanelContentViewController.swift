import SnapKit
import UIKit

open class BaseFloatingPanelContentViewController: BaseViewController, FloatingPanelContentModule {
    open private(set) var scrollView: UIScrollView?
    public private(set) lazy var contentLayout = UILayoutGuide()

    override open func viewDidLoad() {
        super.viewDidLoad()

        setupСontentLayout()
    }

    override open func configureNavigationBar() {}

    private func setupСontentLayout() {
        view.addLayoutGuide(contentLayout)
        contentLayout.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.lessThanOrEqualTo(UIScreen.main.bounds.height - statusBarHeight)
        }
    }
}
