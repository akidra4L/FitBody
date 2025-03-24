import Foundation

struct HospitalMapItem: Decodable, Equatable, Sendable {
    typealias ID = Hospital.ID
    
    let id: ID
    let name: String
    let description: String
    let address: Address
    let rating: Hospital.Rating
}
