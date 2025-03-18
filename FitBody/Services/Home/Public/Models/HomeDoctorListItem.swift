import Foundation

struct HomeDoctorListItem: Decodable, Equatable, Sendable {
    typealias ID = Int
    typealias Rating = Double
    
    let id: ID
    let lastName: String
    let rating: Rating?
    let illustration: URL
}
