import Resolver

extension Resolver {
    static func registerWorkoutServices() {
        register { WorkoutsProviderImpl() }
            .implements(WorkoutsProvider.self)
            .scope(.shared)
    }
}
