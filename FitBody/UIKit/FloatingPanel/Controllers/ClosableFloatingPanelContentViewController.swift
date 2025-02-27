import SnapKit
import UIKit

open class ClosableFloatingPanelContentViewController: BaseFloatingPanelContentViewController {
    private lazy var closeBarButtonItem = makeCloseBarButtonItem()
    public private(set) lazy var navigationBar = makeNavigationBar()

    private var isViewSet = false

    override public var view: UIView! {
        get { super.view }
        set {
            if isViewSet {
                assertionFailure()
            }
            isViewSet = true
            super.view = newValue
        }
    }

    @available(*, unavailable)
    override public func loadView() {
        super.loadView()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override open func configureNavigationBar() {
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
    }

    @objc
    open func closeBarButtonItemDidTap() {}

    private func setup() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeBarButtonItem
        view.addSubview(navigationBar)

        setupConstraints()
    }

    private func setupConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }

    private func makeCloseBarButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeBarButtonItemDidTap)
        )
    }

    private func makeNavigationBar() -> UINavigationBar {
        let navigationBar = UINavigationBar()
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }
}
