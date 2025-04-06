import UIKit

struct WorkoutTopViewModel: Sendable {
    typealias Kind = WorkoutListItem.Kind
    
    var illustration: UIImage {
        switch kind {
        case .fullBody:
            Illustrations.workoutFullBodyIllustration
        case .lowerBody:
            Illustrations.workoutLoweBodyIllustration
        case .ab:
            Illustrations.workoutAbIllustration
        }
    }
    
    private let kind: Kind
    
    init(with kind: Kind) {
        self.kind = kind
    }
}
