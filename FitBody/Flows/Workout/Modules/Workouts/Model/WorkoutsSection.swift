import Foundation

// MARK: - WorkoutsSection

struct WorkoutsSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - WorkoutsSection.Kind

extension WorkoutsSection {
    enum Kind: Equatable, Sendable {
        case top
        case workouts
    }
}

// MARK: - WorkoutsSection.Row

extension WorkoutsSection {
    enum Row: Equatable, Sendable {
        case top
        case workouts(WorkoutListItem)
    }
}
