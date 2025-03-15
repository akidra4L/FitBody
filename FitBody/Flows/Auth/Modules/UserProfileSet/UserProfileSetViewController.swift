import UIKit
import Resolver

// MARK: - UserProfileSetViewOutput

protocol UserProfileSetViewOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - UserProfileSetViewController

final class UserProfileSetViewController: BaseViewController, UserProfileSetViewOutput {
    var onFinish: (() -> Void)?
    
    private lazy var mainView = UserProfileSetView(with: self)
    
    @Injected private var authRegisterProvider: AuthRegisterProvider
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - UserProfileSetViewDelegate

extension UserProfileSetViewController: UserProfileSetViewDelegate {
    func didTapActionButton(in view: UserProfileSetView) {
        let selectedBirthDate = view.selectedBirthDate
        guard
            let selectedGender = view.selectedGender,
            let weight = view.weight,
            let height = view.height
        else {
            view.configureErrorVisibility()
            return
        }
        
        authRegisterProvider.updateAdditionalInfo(
            gender: selectedGender,
            birthDate: selectedBirthDate,
            weight: weight,
            height: height
        )
        
        onFinish?()
    }
}
