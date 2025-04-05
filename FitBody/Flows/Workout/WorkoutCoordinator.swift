import Foundation

// MARK: - WorkoutCoordinatorOutput

protocol WorkoutCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - WorkoutCoordinator

final class WorkoutCoordinator: Coordinator, WorkoutCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let modulesFactory: WorkoutModulesFactory
    
    init(
        router: Router,
        modulesFactory: WorkoutModulesFactory
    ) {
        self.router = router
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentWorkout()
    }
    
    private func presentWorkout() {
        let workout = modulesFactory.makeWorkout()
        router.push(workout) { [onFinish] in
            onFinish?()
        }
    }
}
