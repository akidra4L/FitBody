import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerAppServices()
        registerFoundationServices()
        registerNetworkServices()
    }
    
    private static func registerAppServices() {
        registerAuthServices()
        registerAuthorizedUserDataFetch()
        registerOnboardingServices()
        registerStartupScenarioServices()
        registerUserServices()
    }
}
