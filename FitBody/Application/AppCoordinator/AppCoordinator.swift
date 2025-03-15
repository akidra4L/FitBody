import UIKit
import Resolver

final class AppCoordinator: Coordinator {
    private let coordinatorsFactory = CoordinatorsFactory()
    
    var children: [Coordinator] = []
    
    @Injected private var onboardingProvider: OnboardingProvider
    @Injected private var userAuthStatusProvider: UserAuthStatusProvider
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        if !onboardingProvider.didSee {
            runOnboardingFlow()
        } else {
            userAuthStatusProvider.isAuthenticated
                ? runTabBarFlow()
                : runAuthFlow(state: .login)
        }
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
