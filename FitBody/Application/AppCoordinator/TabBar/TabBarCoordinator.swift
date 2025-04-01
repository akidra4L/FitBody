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
        tabBar.showStartupScenario = { [weak self] launchInstruction in
            self?.runStartupScenarioFlow(with: launchInstruction)
        }
        router.setRootModule(tabBar, animated: true)
    }
    
    private func runHomeFlow() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Home"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let coordinator = coordinatorsFactory.makeHome(
            with: Router(with: navigationController)
        )
        addDependency(coordinator)
        coordinator.start()
        
        return navigationController
    }
    
    private func runSearchFlow() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        let coordinator = coordinatorsFactory.makeSearch(
            with: Router(with: navigationController)
        )
        addDependency(coordinator)
        coordinator.start()
        
        return navigationController
    }
    
    private func runUserProfileFlow() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = "Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        let coordinator = coordinatorsFactory.makeUserProfile(
            with: Router(with: navigationController)
        )
        addDependency(coordinator)
        coordinator.start()
        
        return navigationController
    }
    
    private func runStartupScenarioFlow(with launchInstruction: StartupScenarioLaunchInstruction) {
        let coordinator = coordinatorsFactory.makeStartupScenario(with: router, and: launchInstruction)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func makeFlows() -> [UIViewController] {
        [
            runHomeFlow(),
            runSearchFlow(),
            runUserProfileFlow()
        ]
    }
}
