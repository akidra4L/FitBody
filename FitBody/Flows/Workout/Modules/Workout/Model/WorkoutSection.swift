import Foundation

// MARK: - WorkoutSection

struct WorkoutSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - WorkoutSection.Kind

extension WorkoutSection {
    enum Kind: Equatable, Sendable {
        case top
    }
}

// MARK: - WorkoutSection.Row

extension WorkoutSection {
    enum Row: Equatable, Sendable {
        case top
    }
}
