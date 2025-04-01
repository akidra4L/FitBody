import UIKit
import Resolver

// MARK: - AuthViewOutput

protocol AuthViewOutput: AnyObject {
    var onFinish: ((_ isRegister: Bool) -> Void)? { get set }
}

// MARK: - AuthViewController

final class AuthViewController: BaseViewController, AuthViewOutput {
    typealias State = AuthState
    
    var onFinish: ((Bool) -> Void)?
    
    private lazy var mainView = AuthView(with: state, and: self)
    
    @Injected private var authManager: AuthManager
    @Injected private var authRegisterProvider: AuthRegisterProvider
    @Injected private var authorizedUserDataFetcher: AuthorizedUserDataFetcher
    @Injected private var userSessionCreator: UserSessionCreator
    
    private var state: State {
        didSet {
            guard oldValue != state else {
                return
            }
            
            navigationItem.title = state == .login ? "Welcome back!" : "Create an account"
            mainView.configure(with: state)
        }
    }
    
    init(with state: State) {
        self.state = state
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = state == .login ? "Welcome back!" : "Create an account"
    }
}

// MARK: - AuthViewDelegate

extension AuthViewController: AuthViewDelegate {
    func authView(_ view: AuthView, didTapPrimaryButton button: LoadableButton) {
        switch state {
        case .login:
            handleLogin(button)
        case .register:
            handleRegister()
        }
    }
    
    func didTapSecondaryButton(in view: AuthView) {
        state = (state == .login) ? .register : .login
    }
    
    private func handleLogin(_ button: LoadableButton) {
        guard
            let email = mainView.email,
            let password = mainView.password
        else {
            mainView.configureErrorVisibility()
            return
        }
        
        let request = LoginRequest(email: email, password: password)
        
        button.isLoading = true
        Task { [weak self, manager = authManager, authorizedUserDataFetcher, userSessionCreator] in
            defer {
                button.isLoading = false
            }
            
            do {
                try await manager.login(with: request)
                userSessionCreator.create()
                
                await authorizedUserDataFetcher.fetch()
                
                self?.onFinish?(false)
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func handleRegister() {
        guard
            let firstName = mainView.firstName,
            let lastName = mainView.lastName,
            let email = mainView.email,
            let password = mainView.password
        else {
            mainView.configureErrorVisibility()
            return
        }
        
        authRegisterProvider.updateMainInfo(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
        
        onFinish?(true)
    }
}
