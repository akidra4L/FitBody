import UIKit

struct OnboardingViewModel: Sendable {
    typealias Kind = OnboardingKind
    
    var illustration: UIImage {
        switch kind {
        case .trackProgress:
            Illustrations.onboardingTrackProgressIllustration
        case .startRecovery:
            Illustrations.onboardingStartRecoveryIllustration
        case .eatWell:
            Illustrations.onboardingEatWellIllustration
        case .getSupport:
            Illustrations.onboardingGetSupportIllustration
        case .rehabCenter:
            Illustrations.onboardingRehabCenterIllustration
        }
    }
    
    var title: String {
        switch kind {
        case .trackProgress:
            "Track Your Progress"
        case .startRecovery:
            "Start Your Recovery"
        case .eatWell:
            "Eat Well"
        case .getSupport:
            "Get Expert\nSupport"
        case .rehabCenter:
            "Find the Right\nRehab Center"
        }
    }
    
    var description: String {
        switch kind {
        case .trackProgress:
            "Set personalized rehabilitation goals based on your needs. Track your progress in mobility, strength, and overall recovery every day."
        case .startRecovery:
            "Follow adaptive workout plans tailored to your rehabilitation. Safely regain strength and mobility with exercises designed just for you."
        case .eatWell:
            "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun"
        case .getSupport:
            "Connect with certified physiotherapists and fitness experts. Schedule virtual or in-person sessions for professional advice on your recovery."
        case .rehabCenter:
            "Discover rehabilitation centers near you that specialize in your recovery needs. Filter centers by services, reviews, and proximity to ensure you get the best care."
        }
    }
    
    var actionButtonTitle: String {
        kind == .rehabCenter ? "Let's go!" : "Next"
    }
    
    private let kind: Kind
    
    init(kind: Kind) {
        self.kind = kind
    }
}
