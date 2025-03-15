import Resolver

extension Resolver {
    static func registerOnboardingServices() {
        register { OnboardingManager() }
            .implements(OnboardingProvider.self)
            .implements(OnboardingSeenSetter.self)
            .scope(.shared)
    }
}
