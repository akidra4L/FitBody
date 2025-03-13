import UIKit

final class AppCoordinator: Coordinator {
    private let coordinatorsFactory = CoordinatorsFactory()
    
    var children: [Coordinator] = []
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        runOnboardingFlow()
    }
    
    private func runOnboardingFlow() {
        let coordinator = coordinatorsFactory.makeOnboarding(with: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.runAuthFlow(state: .register)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAuthFlow(state: AuthState) {
        let coordinator = coordinatorsFactory.makeAuth(with: router, state: state)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.runTabBarFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabBarFlow() {
        let coordinator = coordinatorsFactory.makeTabBar(with: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
