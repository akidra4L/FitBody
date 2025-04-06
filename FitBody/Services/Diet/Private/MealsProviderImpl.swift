import Foundation

final class MealsProviderImpl: MealsProvider {
    func get() async throws -> [Meal] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.meals
    }
}
