import UIKit

// MARK: - AuthCoordinatorOutput

protocol AuthCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - AuthCoordinator

final class AuthCoordinator: Coordinator, AuthCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let state: AuthState
    private let modulesFactory: AuthModulesFactory
    
    init(
        router: Router,
        state: AuthState,
        modulesFactory: AuthModulesFactory
    ) {
        self.router = router
        self.state = state
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentAuth()
    }
    
    private func presentAuth() {
        let auth = modulesFactory.makeAuth(with: state)
        router.setRootModule(auth)
    }
}
