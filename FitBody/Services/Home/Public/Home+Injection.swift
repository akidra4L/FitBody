import Resolver

extension Resolver {
    static func registerHomeServices() {
        register { WaterIntakeManager() }
            .implements(WaterIntakeProvider.self)
            .implements(WaterIntakeSetter.self)
            .scope(.shared)
    }
}
