import Foundation

// MARK: - Doctor

struct Doctor: Decodable, Equatable, Sendable {
    typealias ID = Int
    typealias Rating = Double

    let id: ID
    let type: String
    let firstName: String
    let lastName: String
    let illustration: URL
    let rating: Rating?
    let hospital: Hospital
    let yearsExpert: Int
    let description: String
    let reviews: [String]
}

// MARK: - Doctor.Hospital

extension Doctor {
    struct Hospital: Decodable, Equatable, Sendable {
        let name: String
        let address: Address
    }
}
