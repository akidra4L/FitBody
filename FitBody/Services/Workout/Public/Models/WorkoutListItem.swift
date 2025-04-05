import Foundation

// MARK: - WorkoutListItem

struct WorkoutListItem: Decodable, Equatable, Sendable {
    typealias ID = Int
    
    let id: ID
    let kind: Kind
    let title: String
    let exercises: Int
    let duration: Int
}

// MARK: - WorkoutListItem.Kind

extension WorkoutListItem {
    enum Kind: Decodable, Equatable, Sendable {
        case fullBody
        case loweBody
        case ab
    }
}
