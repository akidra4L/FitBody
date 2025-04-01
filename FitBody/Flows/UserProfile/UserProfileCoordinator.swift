import Foundation

// MARK: - UserProfileCoordinatorOutput

protocol UserProfileCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - UserProfileCoordinator

final class UserProfileCoordinator: Coordinator, UserProfileCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: UserProfileModulesFactory
    
    init(
        router: Router,
        modulesFactory: UserProfileModulesFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentUserProfile()
    }
    
    private func presentUserProfile() {
        let userProfile = modulesFactory.makeUserProfile()
        router.setRootModule(userProfile, animated: false)
    }
}
