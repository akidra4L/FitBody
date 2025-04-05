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
        case doctors
        case workout
    }
}

// MARK: - HomeSection.Row

extension HomeSection {
    enum Row: Equatable, Sendable {
        case bookDoctor
        case waterIntake
        case doctors([DoctorListItem])
        case workout
    }
}
