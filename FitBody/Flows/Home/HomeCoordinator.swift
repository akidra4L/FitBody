import Foundation

// MARK: - HomeCoordinatorOutput

protocol HomeCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - HomeCoordinator

final class HomeCoordinator: Coordinator, HomeCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: HomeModulesFactory
    
    init(
        router: Router,
        modulesFactory: HomeModulesFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentHome()
    }
    
    private func presentHome() {
        let home = modulesFactory.makeHome()
        router.setRootModule(home, animated: false)
    }
}
