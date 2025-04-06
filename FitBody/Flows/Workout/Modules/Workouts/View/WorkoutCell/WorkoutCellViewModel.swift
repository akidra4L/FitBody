import UIKit

struct WorkoutCellViewModel: Sendable {
    var title: String {
        workout.title
    }
    
    var subtitle: String {
        "\(workout.exercises) Exercises | \(workout.duration) mins"
    }
    
    var illustration: UIImage {
        switch workout.kind {
        case .fullBody:
            Illustrations.workoutFullBodyIllustration
        case .lowerBody:
            Illustrations.workoutLoweBodyIllustration
        case .ab:
            Illustrations.workoutAbIllustration
        }
    }
    
    let workout: WorkoutListItem
    
    init(with workout: WorkoutListItem) {
        self.workout = workout
    }
}
