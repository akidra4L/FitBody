import Foundation

protocol WorkoutsProvider: AnyObject, Sendable {
    func get() async throws -> [WorkoutListItem]
}
