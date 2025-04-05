import Resolver

final class WorkoutsProviderImpl: WorkoutsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [WorkoutListItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.workouts
    }
}
