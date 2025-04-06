import Foundation

protocol WorkoutModulesFactory: AnyObject {
    func makeWorkouts() -> Presentable & WorkoutsViewOutput
    func makeWorkout(with workoutListItem: WorkoutListItem) -> Presentable & WorkoutViewOutput
}

extension ModulesFactory: WorkoutModulesFactory {
    func makeWorkouts() -> Presentable & WorkoutsViewOutput {
        WorkoutsViewController()
    }
    
    func makeWorkout(with workoutListItem: WorkoutListItem) -> Presentable & WorkoutViewOutput {
        WorkoutViewController(with: workoutListItem)
    }
}
