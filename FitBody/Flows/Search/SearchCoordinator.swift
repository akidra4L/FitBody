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
    private let coordinatorsFactory: CoordinatorsFactory
    
    init(
        router: Router,
        modulesFactory: SearchModulesFactory,
        coordinatorsFactory: CoordinatorsFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        presentSearch()
    }
    
    private func presentSearch() {
        let search = modulesFactory.makeSearch()
        search.hospitalDidSelect = { [weak self] hospital, completion in
            self?.presentSearchDetail(with: hospital, completion: completion)
        }
        router.setRootModule(search, animated: false)
    }
    
    private func presentSearchDetail(with hospitalMapItem: HospitalMapItem, completion: (() -> Void)? = nil) {
        let searchDetail = modulesFactory.makeSearchDetail(with: hospitalMapItem)
        searchDetail.onClose = { [weak self] in
            self?.router.dismissModule {
                completion?()
            }
        }
        searchDetail.onSuccess = { [weak self] in
            self?.router.dismissModule { [weak self] in
                completion?()
                self?.runHospitalFlow(with: hospitalMapItem.id)
            }
        }
        router.presentFloatingPanel(
            contentModule: searchDetail,
            attributes: FloatingPanelAttributes(
                with: .adaptive(contentLayout: searchDetail.contentLayout)
            )
        )
    }
    
    private func runHospitalFlow(with id: Hospital.ID) {
        let coordinator = coordinatorsFactory.makeHospital(with: router, and: id)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
