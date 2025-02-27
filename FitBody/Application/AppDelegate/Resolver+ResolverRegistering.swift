import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerAppServices()
    }
    
    private static func registerAppServices() {}
}
