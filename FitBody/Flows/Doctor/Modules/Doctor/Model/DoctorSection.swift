import Foundation

// MARK: - DoctorSection

struct DoctorSection: Equatable, Sendable {
    let kind: Kind
    let rows: [Row]
}

// MARK: - DoctorSection.Kind

extension DoctorSection {
    enum Kind: Equatable, Sendable {
        case aboutMe
    }
}

// MARK: - DoctorSection.Row

extension DoctorSection {
    enum Row: Equatable, Sendable {
        case aboutMe(String)
    }
}
