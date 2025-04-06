import Resolver

extension Resolver {
    static func registerWorkoutServices() {
        register { WorkoutProviderImpl() }
            .implements(WorkoutProvider.self)
            .scope(.shared)
        
        register { WorkoutsProviderImpl() }
            .implements(WorkoutsProvider.self)
            .scope(.shared)
    }
}
