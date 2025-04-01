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
        registerDoctorServices()
        registerHomeServices()
        registerHospitalServices()
        registerOnboardingServices()
        registerSearchServices()
        registerStartupScenarioServices()
        registerUserServices()
        registerUserSessionServices()
    }
}
