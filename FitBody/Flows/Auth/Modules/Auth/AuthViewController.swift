import UIKit

// MARK: - AuthViewOutput

protocol AuthViewOutput: AnyObject {
    var onSuccess: (() -> Void)? { get set }
}

// MARK: - AuthViewController

final class AuthViewController: BaseViewController, AuthViewOutput {
    typealias State = AuthState
    
    var onSuccess: (() -> Void)?
    
    private lazy var mainView = AuthView(with: state, and: self)
    
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
        
    }
    
    func didTapSecondaryButton(in view: AuthView) {
        state = (state == .login) ? .register : .login
    }
}
