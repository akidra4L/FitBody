import Foundation

// MARK: - SearchCoordinatorOutput

protocol SearchCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - SearchCoordinator

final class SearchCoordinator: Coordinator, SearchCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: SearchModulesFactory
    
    init(
        router: Router,
        modulesFactory: SearchModulesFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentSearch()
    }
    
    private func presentSearch() {
        let search = modulesFactory.makeSearch()
        router.setRootModule(search, animated: false)
    }
}
