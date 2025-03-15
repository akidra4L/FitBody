import Foundation

// MARK: - RegisterRequest

struct RegisterRequest: Encodable, Sendable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var gender: Gender
    var birthDate: Date
    var weight: Double
    var height: Double
    var goal: Goal
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
        self.gender = .man
        self.birthDate = Date()
        self.weight = 0
        self.height = 0
        self.goal = .improveMobility
    }
}

// MARK: - RegisterRequest.Goal

extension RegisterRequest {
    enum Goal: String, CaseIterable, Encodable, Sendable {
        case improveMobility = "IMPROVE_MOBILITY"
        case strengthenMuscles = "STRENGTHEN_MUSCLES"
        case recoverFromInjury = "RECOVER_FROM_INJURY"
    }
}
