import Foundation

// MARK: - HospitalSection

struct HospitalSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - HospitalSection.Kind

extension HospitalSection {
    enum Kind: Equatable, Sendable {
        case top
        case doctors
        case reviews(_ count: Int)
    }
}

// MARK: - HospitalSection.Row

extension HospitalSection {
    enum Row: Equatable, Sendable {
        case top(Hospital)
        case doctors([DoctorListItem])
        case reviews([String])
    }
}
