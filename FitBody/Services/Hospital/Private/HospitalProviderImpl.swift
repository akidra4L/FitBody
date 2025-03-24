import Resolver

final class HospitalProviderImpl: HospitalProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get(with id: Hospital.ID) async throws -> Hospital {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let hospital = MockDataProvider.hospitals.first(where: { $0.id == id }) else {
            assertionFailure()
            return MockDataProvider.hospitals[0]
        }
        
        return hospital
        
//        try await networkClient.get("")
    }
}
