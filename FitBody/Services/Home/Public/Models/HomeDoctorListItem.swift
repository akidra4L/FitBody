import Foundation

struct HomeDoctorListItem: Decodable, Equatable, Sendable {
    typealias ID = Doctor.ID
    
    let id: ID
    let lastName: String
    let rating: Doctor.Rating?
    let illustration: URL
    let address: String
}
