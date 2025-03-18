import UIKit
import Resolver

// MARK: - DoctorOnboardingViewOutput

protocol DoctorOnboardingViewOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - DoctorOnboardingViewController

final class DoctorOnboardingViewController: BaseViewController, DoctorOnboardingViewOutput {
    var onFinish: (() -> Void)?
    
    private lazy var mainView = DoctorOnboardingView(with: self)
    
    @Injected private var doctorOnboardingSeenSetter: DoctorOnboardingSeenSetter
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorOnboardingSeenSetter.set()
    }
    
    override func configureNavigationBar() {}
}

// MARK: - DoctorOnboardingViewDelegate

extension DoctorOnboardingViewController: DoctorOnboardingViewDelegate {
    func didTapActionButton(in view: DoctorOnboardingView) {
        onFinish?()
    }
}
