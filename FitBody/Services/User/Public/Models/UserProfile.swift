import Foundation

struct UserProfile: Codable, Equatable, Sendable {
    let firstName: String
    let lastName: String
    let email: String
    let gender: Gender
    let birthDate: Date
    let weight: Double
    let height: Double
}
