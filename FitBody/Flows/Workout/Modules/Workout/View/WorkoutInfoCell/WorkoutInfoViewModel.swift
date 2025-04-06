import Foundation

struct WorkoutInfoViewModel: Sendable {
    var title: String {
        workoutListItem.title
    }
    
    var subtitle: String {
        "\(workoutListItem.exercises) Exercises | \(workoutListItem.duration) mins"
    }
    
    private let workoutListItem: WorkoutListItem
    
    init(with workoutListItem: WorkoutListItem) {
        self.workoutListItem = workoutListItem
    }
}
