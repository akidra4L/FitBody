import Resolver

extension Resolver {
    static func registerUserServices() {
        register { UserProfileProviderImpl() }
            .implements(UserProfileProvider.self)
            .scope(.application)
    }
}
