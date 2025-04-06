import Foundation

protocol WorkoutProvider: AnyObject, Sendable {
    func get(with id: Workout.ID) async throws -> Workout
}
