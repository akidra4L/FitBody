import Resolver

extension Resolver {
    static func registerUserServices() {
        register { UserProfileManager() }
            .implements(UserProfileProvider.self)
            .implements(UserProfileCleaner.self)
            .scope(.application)
    }
}
