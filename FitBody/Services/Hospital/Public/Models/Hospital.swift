import Foundation

struct Hospital: Decodable, Equatable, Sendable {
    typealias ID = Int
    
    let id: ID
    let name: String
    let address: Address
}
