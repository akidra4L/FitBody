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
        diet.addMealTap = { [weak self] completion in
            self?.presentMealAdd(completion: completion)
        }
        router.push(diet) { [onFinish] in
            onFinish?()
        }
    }
    
    private func presentMealAdd(completion: @escaping (Meal) -> Void) {
        let mealAdd = modulesFactory.makeMealAdd()
        mealAdd.onClose = { [weak self] in
            self?.router.dismissModule()
        }
        mealAdd.onSuccess = { [weak self] meal in
            self?.router.dismissModule {
                completion(meal)
            }
        }
        router.presentFloatingPanel(
            contentModule: mealAdd,
            attributes: FloatingPanelAttributes(
                with: .adaptive(contentLayout: mealAdd.contentLayout)
            )
        )
    }
}
