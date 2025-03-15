import UIKit

final class TabBarCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: AppModulesFactory
    private let coordinatorsFactory: CoordinatorsFactory
    
    init(
        router: Router,
        modulesFactory: AppModulesFactory,
        coordinatorsFactory: CoordinatorsFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        presentTabBar()
    }
    
    private func presentTabBar() {
        let tabBar = modulesFactory.makeTabBar(
            with: makeFlows()
        )
        router.setRootModule(tabBar, animated: true)
    }
    
    private func makeFlows() -> [UIViewController] {
        [
            
        ]
    }
}
