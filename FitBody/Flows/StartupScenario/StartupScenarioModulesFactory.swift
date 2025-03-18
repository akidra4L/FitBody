import Foundation

protocol StartupScenarioModulesFactory: AnyObject {
    func makeDoctorOnboarding() -> Presentable & DoctorOnboardingViewOutput
}

extension ModulesFactory: StartupScenarioModulesFactory {
    func makeDoctorOnboarding() -> Presentable & DoctorOnboardingViewOutput {
        DoctorOnboardingViewController()
    }
}
