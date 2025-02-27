import UIKit

final class CoordinatorsFactory {
    func makeApp(with router: Router) -> Coordinator {
        AppCoordinator(router: router)
    }
    
    func makeTabBar(with router: Router) -> Coordinator {
        TabBarCoordinator(
            router: router,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
}
