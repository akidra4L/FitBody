import Foundation

// MARK: - Meal

struct Meal: Decodable, Equatable, Sendable {
    let kind: Kind
    let title: String
    let date: Date
}

// MARK: - Meal.Kind

extension Meal {
    enum Kind: Decodable, Equatable, Sendable {
        case breakfast
        case lunch
        case snacks
        case dinner
    }
}
