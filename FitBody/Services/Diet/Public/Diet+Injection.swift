import Resolver

extension Resolver {
    static func registerDietServices() {
        register { MealsProviderImpl() }
            .implements(MealsProvider.self)
            .scope(.shared)
    }
}
