import Foundation

protocol WorkoutModulesFactory: AnyObject {
    func makeWorkouts() -> Presentable & WorkoutsViewOutput
}

extension ModulesFactory: WorkoutModulesFactory {
    func makeWorkouts() -> Presentable & WorkoutsViewOutput {
        WorkoutsViewController()
    }
}
