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
//                self?.runRestaurant(with: restaurantMapItem.id)
            }
        }
        router.presentFloatingPanel(
            contentModule: searchDetail,
            attributes: FloatingPanelAttributes(
                with: .adaptive(contentLayout: searchDetail.contentLayout)
            )
        )
    }
}
