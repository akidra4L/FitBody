import UIKit
import SnapKit
import Resolver

// MARK: - LaunchScreenViewOutput

protocol LaunchScreenViewOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - LaunchScreenViewController

final class LaunchScreenViewController: BaseViewController, LaunchScreenViewOutput {
    var onFinish: (() -> Void)?
    
    @Injected private var authorizedUserDataFetcher: AuthorizedUserDataFetcher
    
    private lazy var mainView = LaunchScreenView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preloadServices()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        NavigationBarConfigurator().configure(navigationBar: navigationBar, with: .transparent)
    }
    
    private func preloadServices() {
        Task { [weak self, authorizedUserDataFetcher] in
            defer {
                self?.onFinish?()
            }
            
            await authorizedUserDataFetcher.fetch()
        }
    }
}
