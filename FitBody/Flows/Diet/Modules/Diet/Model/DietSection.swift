import UIKit

// MARK: - DietSection

struct DietSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - DietSection.Kind

extension DietSection {
    enum Kind: Equatable, Sendable {
        case top
        case meals(String, _ count: Int)
    }
}

// MARK: - DietSection.Row

extension DietSection {
    enum Row: Equatable, Sendable {
        case top
        case meal(Meal)
    }
}
