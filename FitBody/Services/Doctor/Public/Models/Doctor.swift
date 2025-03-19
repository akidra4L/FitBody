import Foundation

struct Doctor: Decodable, Equatable, Sendable {
    typealias ID = Int
    typealias Rating = Double

    let id: ID
    let type: String
    let firstName: String
    let lastName: String
    let illustration: URL
    let rating: Rating?
    let hospital: String?
    let yearsExpert: Int
    let description: String
    let reviews: [String]
}
