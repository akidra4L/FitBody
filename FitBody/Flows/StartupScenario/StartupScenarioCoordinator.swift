import Foundation

// MARK: - StartupScenarioCoordinatorOutput

protocol StartupScenarioCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - StartupScenarioCoordinator

final class StartupScenarioCoordinator: Coordinator, StartupScenarioCoordinatorOutput {
    typealias LaunchInstruction = StartupScenarioLaunchInstruction
    
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let launchInstruction: LaunchInstruction
    private let modulesFactory: StartupScenarioModulesFactory
    
    init(
        router: Router,
        launchInstruction: LaunchInstruction,
        modulesFactory: StartupScenarioModulesFactory
    ) {
        self.router = router
        self.launchInstruction = launchInstruction
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        switch launchInstruction {
        case .doctorOnboarding:
            presentDoctorOnboarding()
        }
    }
    
    private func presentDoctorOnboarding() {
        let doctorOnboarding = modulesFactory.makeDoctorOnboarding()
        doctorOnboarding.onFinish = { [weak self] in
            self?.router.dismissModule { [weak self] in
                self?.onFinish?()
            }
        }
        router.present(doctorOnboarding, modalPresentationStyle: .fullScreen)
    }
}
