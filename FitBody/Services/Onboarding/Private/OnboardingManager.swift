import Foundation

// MARK: - OnboardingManager

final class OnboardingManager {
    private let cachedDidSee = UserDefaultsNonOptionalWrapper(
        key: "didSeeOnboarding",
        defaultValue: false
    )
}

// MARK: - OnboardingProvider

extension OnboardingManager: OnboardingProvider {
    var didSee: Bool {
        cachedDidSee.value
    }
}

// MARK: - OnboardingSeenSetter

extension OnboardingManager: OnboardingSeenSetter {
    func set() {
        cachedDidSee.update(with: true)
    }
}
