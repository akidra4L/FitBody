import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerAppServices()
        registerNetworkServices()
    }
    
    private static func registerAppServices() {
        registerAuthServices()
        registerOnboardingServices()
        registerUserServices()
    }
}
