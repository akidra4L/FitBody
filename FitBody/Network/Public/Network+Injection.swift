import Resolver

extension Resolver {
    static func registerNetworkServices() {
        register { NetworkClientImpl() }
            .implements(NetworkClient.self)
            .scope(.shared)
    }
}
