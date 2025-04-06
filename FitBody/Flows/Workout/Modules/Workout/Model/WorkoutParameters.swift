import Foundation

struct WorkoutParameters: Sendable {
    var isLoaded = false
    var workout: Workout? = nil
    
    let workoutListItem: WorkoutListItem
    
    init(with workoutListItem: WorkoutListItem) {
        self.workoutListItem = workoutListItem
    }
}
