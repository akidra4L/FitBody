import Foundation

struct WorkoutExerciseViewModel: Sendable {
    typealias Exercise = Workout.Exercise
    
    var image: URL {
        exercise.image
    }
    
    var title: String {
        exercise.title
    }
    
    var isHiddenSubtitle: Bool {
        subtitle == nil
    }
    
    var subtitle: String? {
        if let duration = exercise.duration {
            formatSecondsToMinutes(duration) + " mins"
        } else if let repeats = exercise.repeats {
            "\(repeats) repeats"
        } else {
            nil
        }
    }
    
    private let exercise: Exercise
    
    init(with exercise: Exercise) {
        self.exercise = exercise
    }
    
    private func formatSecondsToMinutes(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
