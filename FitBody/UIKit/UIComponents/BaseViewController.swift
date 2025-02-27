import UIKit

// MARK: - BaseViewController

open class BaseViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        nil
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationItem.backBarButtonItem = BackBarButtonItem()
    }
    
    open func configureNavigationBar() {
        assertionFailure("Something goes wrong!, \(self)")
    }
}

// MARK: - BaseViewController + StatusBarHeight

extension BaseViewController {
    var statusBarHeight: CGFloat {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let statusBarManager = windowScene.statusBarManager
        else {
            assertionFailure()
            return 0
        }

        return statusBarManager.statusBarFrame.height
    }
}

// MARK: - BaseViewController + NavigationViewHeight

extension BaseViewController {
    var navigationViewHeight: CGFloat {
        statusBarHeight + 44
    }

    var tabBarHeight: CGFloat {
        tabBarController?.tabBar.frame.height ?? 0
    }
}
