import UIKit

final class CoordinatorsFactory {
    func makeApp(with router: Router) -> Coordinator {
        AppCoordinator(router: router)
    }
    
    func makeOnboarding(with router: Router) -> Coordinator & OnboardingCoordinatorOutput {
        OnboardingCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeTabBar(with router: Router) -> Coordinator {
        TabBarCoordinator(
            router: router,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
}
