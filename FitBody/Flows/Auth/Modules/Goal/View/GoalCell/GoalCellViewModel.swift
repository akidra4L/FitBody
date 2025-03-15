import UIKit

struct GoalCellViewModel: Sendable {
    typealias Goal = RegisterRequest.Goal
    
    var illustration: UIImage {
        switch goal {
        case .improveMobility:
            Illustrations.goalImproveMobilityIllustration
        case .strengthenMuscles:
            Illustrations.goalStrengthenMusclesIllustration
        case .recoverFromInjury:
            Illustrations.goalRecoverFromInjuryIllustration
        }
    }
    
    var illustrationHeight: CGFloat {
        switch goal {
        case .improveMobility:
            290
        case .strengthenMuscles:
            294
        case .recoverFromInjury:
            264
        }
    }
    
    var title: String {
        switch goal {
        case .improveMobility:
            "Improve Mobility"
        case .strengthenMuscles:
            "Strengthen Muscles"
        case .recoverFromInjury:
            "Recover from Injury"
        }
    }
    
    var description: String {
        switch goal {
        case .improveMobility:
            "I want to regain or improve my mobility after an injury or surgery and focus on movement exercises that will help me get back to normal activities"
        case .strengthenMuscles:
            "I have lost muscle strength due to injury or inactivity. I want to rebuild my strength safely through adaptive exercises"
        case .recoverFromInjury:
            "I am recovering from a specific injury and need a personalized workout plan to help me rehabilitate and regain full functionality"
        }
    }
    
    let goal: Goal
    
    init(with goal: Goal) {
        self.goal = goal
    }
}
