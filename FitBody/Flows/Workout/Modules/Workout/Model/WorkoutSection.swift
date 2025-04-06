import UIKit

// MARK: - WorkoutSection

struct WorkoutSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - WorkoutSection.Kind

extension WorkoutSection {
    enum Kind: Equatable, Sendable {
        case top
        case info
        case equipments(_ count: Int)
        case exercises
    }
}

// MARK: - WorkoutSection.Row

extension WorkoutSection {
    enum Row: Equatable, Sendable {
        case top(WorkoutListItem.Kind)
        case info(WorkoutListItem)
        case equipments([Workout.Equipment])
        case exercise(Workout.Exercise)
    }
}
