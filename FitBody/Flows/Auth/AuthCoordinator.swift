import UIKit
import Resolver

// MARK: - AuthCoordinatorOutput

protocol AuthCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - AuthCoordinator

final class AuthCoordinator: Coordinator, AuthCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    @Injected private var userProfileProvider: UserProfileProvider
    
    var router: Router
    private let state: AuthState
    private let modulesFactory: AuthModulesFactory
    
    init(
        router: Router,
        state: AuthState,
        modulesFactory: AuthModulesFactory
    ) {
        self.router = router
        self.state = state
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentAuth()
    }
    
    private func presentAuth() {
        let auth = modulesFactory.makeAuth(with: state)
        auth.onFinish = { [weak self] isRegister in
            isRegister ? self?.presentUserProfileSet() : self?.presentAuthSuccess()
        }
        router.setRootModule(auth)
    }
    
    private func presentAuthSuccess() {
        guard let name = userProfileProvider.userProfile?.firstName else {
            assertionFailure()
            return
        }
        
        let authSuccess = modulesFactory.makeAuthSuccess(with: name)
        authSuccess.onFinish = { [weak self] in
            self?.router.dismissModule { [weak self] in
                self?.onFinish?()
            }
        }
        router.present(authSuccess, animated: true, modalPresentationStyle: .fullScreen)
    }
    
    private func presentGoal() {
        let goal = modulesFactory.makeGoal()
        goal.onFinish = { [weak self] in
            self?.presentAuthSuccess()
        }
        router.push(goal)
    }
    
    private func presentUserProfileSet() {
        let userProfileSet = modulesFactory.makeUserProfileSet()
        userProfileSet.onFinish = { [weak self] in
            self?.presentGoal()
        }
        router.push(userProfileSet)
    }
}
