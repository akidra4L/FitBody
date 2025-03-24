import Resolver

extension Resolver {
    static func registerDoctorServices() {
        register { DoctorProviderImpl() }
            .implements(DoctorProvider.self)
            .scope(.shared)
        
        register { DoctorsProviderImpl() }
            .implements(DoctorsProvider.self)
            .scope(.shared)
    }
}
