import Foundation

final class WorkoutSectionsFactory {
    func make(from parameters: WorkoutParameters) -> [WorkoutSection] {
        [
            WorkoutSection(kind: .top, rows: [.top(parameters.workoutListItem.kind)]),
            WorkoutSection(kind: .info, rows: [.info(parameters.workoutListItem)]),
            makeEquipmentsSection(with: parameters.workout?.equipments),
            makeExerciseSection(with: parameters.workout?.exercises)
        ].compactMap { $0 }
    }
    
    private func makeEquipmentsSection(with equipments: [Workout.Equipment]?) -> WorkoutSection? {
        guard
            let equipments,
            !equipments.isEmpty else {
            return nil
        }
        
        return WorkoutSection(
            kind: .equipments(equipments.count),
            rows: [.equipments(equipments)]
        )
    }
    
    private func makeExerciseSection(with exercises: [Workout.Exercise]?) -> WorkoutSection? {
        guard
            let exercises,
            !exercises.isEmpty
        else {
            return nil
        }
        
        return WorkoutSection(
            kind: .exercises,
            rows: exercises.map { .exercise($0) }
        )
    }
}
