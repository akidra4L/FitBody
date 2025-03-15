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
    
    @Injected private var authRegisterProvider: AuthRegisterProvider
    
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
    func didTapPrimaryButton(in view: AuthView) {
        switch state {
        case .login:
            guard
                let email = view.email,
                let password = view.password
            else {
                mainView.configureErrorVisibility()
                return
            }
            
            onFinish?(false)
        case .register:
            guard
                let firstName = view.firstName,
                let lastName = view.lastName,
                let email = view.email,
                let password = view.password
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
    
    func didTapSecondaryButton(in view: AuthView) {
        state = (state == .login) ? .register : .login
    }
}
