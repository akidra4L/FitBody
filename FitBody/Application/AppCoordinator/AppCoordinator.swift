import UIKit
import Resolver

final class AppCoordinator: Coordinator {
    private let coordinatorsFactory = CoordinatorsFactory()
    
    var children: [Coordinator] = []
    
    @Injected private var onboardingProvider: OnboardingProvider
    @Injected private var userProfileProvider: UserProfileProvider
    
    var router: Router
    private let modulesFactory: AppModulesFactory
    
    init(router: Router, modulesFactory: AppModulesFactory) {
        self.router = router
        self.modulesFactory = modulesFactory
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
            (userProfileProvider.userProfile == nil)
                ? runAuthFlow(state: .login)
                : runTabBarFlow()
        }
    }
}
