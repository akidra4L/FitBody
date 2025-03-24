import Foundation

// MARK: - Hospital

struct Hospital: Decodable, Equatable, Sendable {
    typealias ID = Int
    
    let id: ID
    let name: String
    let description: String
    let banner: URL
    let address: Address
    let rating: Rating
    let doctors: [Doctor.ID]
}

// MARK: - Hospital.Rating

extension Hospital {
    struct Rating: Decodable, Equatable, Sendable {
        typealias Score = Double
        
        let score: Score
        let reviews: [String]
    }
}
