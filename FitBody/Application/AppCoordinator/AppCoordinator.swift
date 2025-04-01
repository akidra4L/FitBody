import UIKit
import Resolver

final class AppCoordinator: Coordinator {
    private let coordinatorsFactory = CoordinatorsFactory()
    
    var children: [Coordinator] = []
    
    @Injected private var onboardingProvider: OnboardingProvider
    @Injected private var userSessionProvider: UserSessionProvider
    
    var router: Router
    private let modulesFactory: AppModulesFactory
    
    init(router: Router, modulesFactory: AppModulesFactory) {
        self.router = router
        self.modulesFactory = modulesFactory
        
        userSessionProvider.addObserver(self)
    }
    
    func start() {
        removeAll()
        presentLaunchScreen()
    }
    
    private func presentLaunchScreen() {
        let launchScreen = modulesFactory.makeLaunchScreen()
        launchScreen.onFinish = { [weak self] in
            self?.handleFlowAfterLaunch()
        }
        router.setRootModule(launchScreen)
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
    
    private func handleFlowAfterLaunch() {
        removeAll()
        if !onboardingProvider.didSee {
            runOnboardingFlow()
        } else {
            (userSessionProvider.isActive == false)
                ? runAuthFlow(state: .login)
                : runTabBarFlow()
        }
    }
}

// MARK: - UserSessionProviderObserver

extension AppCoordinator: UserSessionProviderObserver {
    func userSessionProvider(_ provider: UserSessionProvider, didChangeUserSession isActive: Bool) {
        guard !isActive else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.start()
        }
    }
}
