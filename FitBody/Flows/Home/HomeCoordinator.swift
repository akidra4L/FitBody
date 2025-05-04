import Foundation

// MARK: - HomeCoordinatorOutput

protocol HomeCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - HomeCoordinator

final class HomeCoordinator: Coordinator, HomeCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: HomeModulesFactory
    private let coordinatorsFactory: CoordinatorsFactory
    
    init(
        router: Router,
        modulesFactory: HomeModulesFactory,
        coordinatorsFactory: CoordinatorsFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        presentHome()
    }
    
    private func presentHome() {
        let home = modulesFactory.makeHome()
        home.doctorDidSelect = { [weak self] id in
            self?.runDoctorFlow(with: id)
        }
        home.workoutDidSelect = { [weak self] in
            self?.runWorkoutFlow()
        }
        home.dietDidSelect = { [weak self] in
            self?.runDietFlow()
        }
        home.consultationDidSelect = { [weak self] in
            self?.presentConsultation()
        }
        router.setRootModule(home, animated: false)
    }
    
    private func presentConsultation() {
        let consultation = modulesFactory.makeConsultation()
        router.push(consultation)
    }
    
    private func runDoctorFlow(with id: Doctor.ID) {
        let coordinator = coordinatorsFactory.makeDoctor(with: router, id: id)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runWorkoutFlow() {
        let coordinator = coordinatorsFactory.makeWorkout(with: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runDietFlow() {
        let coordinator = coordinatorsFactory.makeDiet(with: router)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
