import Foundation

// MARK: - DietCoordinatorOutput

protocol DietCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - DietCoordinator

final class DietCoordinator: Coordinator, DietCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: DietModulesFactory
    
    init(
        router: Router,
        modulesFactory: DietModulesFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentDiet()
    }
    
    private func presentDiet() {
        let diet = modulesFactory.makeDiet()
        router.push(diet) { [onFinish] in
            onFinish?()
        }
    }
}
