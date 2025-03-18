import Resolver

extension Resolver {
    static func registerStartupScenarioServices() {
        register { DoctorOnboardingManager() }
            .implements(DoctorOnboardingProvider.self)
            .implements(DoctorOnboardingSeenSetter.self)
            .scope(.shared)
    }
}
