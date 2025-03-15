import UIKit

// MARK: - AuthSuccessViewOutput

protocol AuthSuccessViewOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - AuthSuccessViewController

final class AuthSuccessViewController: BaseViewController, AuthSuccessViewOutput {
    var onFinish: (() -> Void)?
    
    private lazy var mainView = AuthSuccessView(
        with: name,
        and: self
    )
    
    private let name: String
    
    init(with name: String) {
        self.name = name
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationBar() {}
}

// MARK: - AuthSuccessViewDelegate

extension AuthSuccessViewController: AuthSuccessViewDelegate {
    func didTapActionButton(in view: AuthSuccessView) {
        onFinish?()
    }
}
