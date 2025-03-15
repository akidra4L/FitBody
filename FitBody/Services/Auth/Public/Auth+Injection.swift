import Resolver

extension Resolver {
    static func registerAuthServices() {
        register { AuthManagerImpl() }
            .implements(AuthManager.self)
            .scope(.shared)
        
        register { AuthRegisterProviderImpl() }
            .implements(AuthRegisterProvider.self)
            .scope(.application)
    }
}
