import Resolver

extension Resolver {
    static func registerHospitalServices() {
        register { HospitalProviderImpl() }
            .implements(HospitalProvider.self)
            .scope(.shared)
    }
}
