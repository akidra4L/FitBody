import Foundation

protocol OnboardingModulesFactory: AnyObject {
    func makeOnboarding(with kind: OnboardingKind) -> Presentable & OnboardingViewOutput
}

extension ModulesFactory: OnboardingModulesFactory {
    func makeOnboarding(with kind: OnboardingKind) -> Presentable & OnboardingViewOutput {
        OnboardingViewController(with: kind)
    }
}
