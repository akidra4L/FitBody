import Foundation

// MARK: - UserProfile

struct UserProfile: Codable, Equatable, Sendable {
    let firstName: String
    let lastName: String
    let email: String
    let gender: Gender
    let birthDate: Date
    let weight: Double
    let height: Double
}

// MARK: - UserProfile.age

extension UserProfile {
    var age: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        return ageComponents.year ?? 0
    }
}
