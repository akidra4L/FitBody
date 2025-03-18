import Resolver

extension Resolver {
    static func registerHomeServices() {
        register { HomeDoctorsProviderImpl() }
            .implements(HomeDoctorsProvider.self)
            .scope(.shared)
        
        register { WaterIntakeManager() }
            .implements(WaterIntakeProvider.self)
            .implements(WaterIntakeSetter.self)
            .scope(.shared)
    }
}
