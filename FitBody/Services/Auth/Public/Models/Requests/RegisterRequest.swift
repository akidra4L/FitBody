import Foundation

// MARK: - RegisterRequest

struct RegisterRequest: Encodable, Sendable {
    let firstName: String
    let secondName: String
    let email: String
    let password: String
    let gender: Gender
    let birthDate: Date
    let weight: Int
    let height: Int
    let goal: Goal
}

// MARK: - RegisterRequest.Goal

extension RegisterRequest {
    enum Goal: String, CaseIterable, Encodable, Sendable {
        case improveMobility = "IMPROVE_MOBILITY"
        case strengthenMuscles = "STRENGTHEN_MUSCLES"
        case recoverFromInjury = "RECOVER_FROM_INJURY"
    }
}
