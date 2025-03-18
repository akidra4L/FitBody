import Foundation

// MARK: - HomeSection

struct HomeSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - HomeSection.Kind

extension HomeSection {
    enum Kind: Equatable, Sendable {
        case bookDoctor
        case waterIntake
    }
}

// MARK: - HomeSection.Row

extension HomeSection {
    enum Row: Equatable, Sendable {
        case bookDoctor
        case waterIntake
    }
}
