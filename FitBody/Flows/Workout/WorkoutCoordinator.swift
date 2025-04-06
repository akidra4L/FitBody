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
        presentWorkouts()
    }
    
    private func presentWorkouts() {
        let workouts = modulesFactory.makeWorkouts()
        workouts.workoutDidSelect = { [weak self] workout in
            self?.presentWorkout(with: workout)
        }
        router.push(workouts) { [onFinish] in
            onFinish?()
        }
    }
    
    private func presentWorkout(with workoutListItem: WorkoutListItem) {
        let workout = modulesFactory.makeWorkout(with: workoutListItem)
        router.push(workout)
    }
}
