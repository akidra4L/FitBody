import Resolver

extension Resolver {
    static func registerUserSessionServices() {
        register { UserSessionManager() }
            .implements(UserSessionCreator.self)
            .implements(UserSessionDestroyer.self)
            .implements(UserSessionProvider.self)
            .scope(.shared)
    }
}
