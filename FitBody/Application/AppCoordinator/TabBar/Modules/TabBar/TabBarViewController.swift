import UIKit
import Resolver

// MARK: - TabBarViewOutput

protocol TabBarViewOutput: AnyObject {
    var showStartupScenario: ((StartupScenarioLaunchInstruction) -> Void)? { get set }
}

// MARK: - TabBarViewController

final class TabBarViewController: UITabBarController, TabBarViewOutput {
    var showStartupScenario: ((StartupScenarioLaunchInstruction) -> Void)?
    
    private var viewDidAppeared = false
    
    @Injected private var doctorOnboardingProvider: DoctorOnboardingProvider
    
    init(with viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !viewDidAppeared {
            viewDidAppeared = true
            showStartupScenarioIfNeeded()
        }
    }
    
    @objc
    private func handleChangeIndex(_ notification: NSNotification) {
        guard let index = notification.userInfo?["selectedTabBarIndex"] as? Int else {
            return
        }
        
        selectedIndex = index
    }
    
    private func showStartupScenarioIfNeeded() {
        if !doctorOnboardingProvider.didSee {
            showStartupScenario?(.doctorOnboarding)
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleChangeIndex),
            name: Notification.Name("changeTabBarIndex"),
            object: nil
        )
    }
}
