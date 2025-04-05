import Foundation

protocol WorkoutModulesFactory: AnyObject {
    func makeWorkout() -> Presentable & WorkoutViewOutput
}

extension ModulesFactory: WorkoutModulesFactory {
    func makeWorkout() -> Presentable & WorkoutViewOutput {
        WorkoutViewController()
    }
}
