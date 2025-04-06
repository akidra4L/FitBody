import Resolver

final class WorkoutProviderImpl: WorkoutProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get(with id: Workout.ID) async throws -> Workout {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let workout = MockDataProvider.workouts.first(where: { $0.id == id }) else {
            return MockDataProvider.workouts[0]
        }
        
        return workout
    }
}
