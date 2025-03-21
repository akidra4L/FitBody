import Resolver

extension Resolver {
    static func registerSearchServices() {
        register { HospitalMapItemsProviderImpl() }
            .implements(HospitalMapItemsProvider.self)
            .scope(.shared)
    }
}
