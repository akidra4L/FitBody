import Foundation

struct HospitalMapItem: Decodable, Equatable, Sendable {
    typealias ID = Hospital.ID
    
    let id: ID
    let address: Address
}
