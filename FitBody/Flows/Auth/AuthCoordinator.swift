import UIKit

protocol AuthCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

final class AuthCoordinator: Coordinator, AuthCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: AuthModulesFactory
    
    init(router: Router, modulesFactory: AuthModulesFactory) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        
    }
}
