import Foundation

// MARK: - Workout

struct Workout: Decodable, Equatable, Sendable {
    typealias ID = Int
    
    let id: Int
    let difficulty: String
    let equipments: [Equipment]
    let exercises: [Exercise]
}

// MARK: - Workout.Equipment

extension Workout {
    struct Equipment: Decodable, Equatable, Sendable {
        let icon: URL
        let title: String
    }
}

// MARK: - Workout.Exercise

extension Workout {
    struct Exercise: Decodable, Equatable, Sendable {
        typealias ID = Int
        
        let id: ID
        let image: URL
        let title: String
        let duration: Int?
        let repeats: Int?
    }
}
