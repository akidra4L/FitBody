import Resolver

extension Resolver {
    static func registerUserServices() {
        register { UserAuthStatusManager() }
            .implements(UserAuthStatusProvider.self)
            .implements(UserAuthStatusResetter.self)
            .implements(UserAuthStatusSetter.self)
            .scope(.shared)
    }
}
