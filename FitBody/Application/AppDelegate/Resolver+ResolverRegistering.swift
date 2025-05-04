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
        registerDietServices()
        registerDoctorServices()
        registerGeminiServices()
        registerHomeServices()
        registerHospitalServices()
        registerOnboardingServices()
        registerSearchServices()
        registerStartupScenarioServices()
        registerUserServices()
        registerUserSessionServices()
        registerWorkoutServices()
    }
}
