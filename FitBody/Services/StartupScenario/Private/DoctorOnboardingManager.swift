import Foundation

// MARK: - DoctorOnboardingManager

final class DoctorOnboardingManager {
    private let cachedDidSee = UserDefaultsNonOptionalWrapper(
        key: "didSeeDoctorOnboarding",
        defaultValue: false
    )
}

// MARK: - OnboardingProvider

extension DoctorOnboardingManager: DoctorOnboardingProvider {
    var didSee: Bool {
        cachedDidSee.value
    }
}

// MARK: - DoctorOnboardingSeenSetter

extension DoctorOnboardingManager: DoctorOnboardingSeenSetter {
    func set() {
        cachedDidSee.update(with: true)
    }
}
