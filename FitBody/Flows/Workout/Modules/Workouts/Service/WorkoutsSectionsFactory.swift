import Foundation

final class WorkoutsSectionsFactory {
    func make(with parameters: WorkoutsParameters) -> [WorkoutsSection] {
        [
            WorkoutsSection(kind: .top, rows: [.top]),
            makeWorkoutsSection(from: parameters.workouts)
        ].compactMap { $0 }
    }
    
    func makeWorkoutsSection(from workouts: [WorkoutListItem]) -> WorkoutsSection? {
        guard !workouts.isEmpty else {
            return nil
        }
        
        return WorkoutsSection(
            kind: .workouts,
            rows: workouts.map { .workouts($0) }
        )
    }
}
