import UIKit

// MARK: - OnboardingCoordinatorOutput

protocol OnboardingCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - OnboardingCoordinator

final class OnboardingCoordinator: Coordinator, OnboardingCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: OnboardingModulesFactory
    
    init(router: Router, modulesFactory: OnboardingModulesFactory) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentOnboarding(with: .trackProgress)
    }
    
    private func presentOnboarding(with kind: OnboardingKind) {
        let onboarding = modulesFactory.makeOnboarding(with: kind)
        onboarding.onFinish = { [weak self] kind in
            self?.handleOnboardingStep(with: kind)
        }
        kind == .trackProgress ? router.setRootModule(onboarding) : router.push(onboarding)
    }
    
    private func handleOnboardingStep(with kind: OnboardingKind) {
        switch kind {
        case .trackProgress:
            presentOnboarding(with: .startRecovery)
        case .startRecovery:
            presentOnboarding(with: .eatWell)
        case .eatWell:
            presentOnboarding(with: .getSupport)
        case .getSupport:
            presentOnboarding(with: .rehabCenter)
        case .rehabCenter:
            onFinish?()
        }
    }
}
