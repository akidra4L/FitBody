import Resolver

extension Resolver {
    static func registerGeminiServices() {
        register { GeminiProviderImpl() }
            .implements(GeminiProvider.self)
            .scope(.shared)
    }
}
