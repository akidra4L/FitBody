import UIKit
import SnapKit

// MARK: - OnboardingViewOutput

protocol OnboardingViewOutput: AnyObject {
    var onFinish: ((_ kind: OnboardingKind) -> Void)? { get set }
}

// MARK: - OnboardingViewController

final class OnboardingViewController: BaseViewController, OnboardingViewOutput {
    typealias Kind = OnboardingKind
    
    var onFinish: ((Kind) -> Void)?
    
    private lazy var mainView = OnboardingView(
        with: OnboardingViewModel(kind: kind),
        and: self
    )
    
    private let kind: Kind
    
    init(with kind: Kind) {
        self.kind = kind
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
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar, with: .transparent)
    }
}

// MARK: - OnboardingViewDelegate

extension OnboardingViewController: OnboardingViewDelegate {
    func didTapActionButton(in view: OnboardingView) {
        onFinish?(kind)
    }
}
