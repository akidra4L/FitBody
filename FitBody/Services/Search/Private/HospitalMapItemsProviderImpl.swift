import Resolver

final class HospitalMapItemsProviderImpl: HospitalMapItemsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [HospitalMapItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.hospitals.map {
            HospitalMapItem(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                address: $0.address, rating: $0.rating
            )
        }
        
//        try await networkClient.get("")
    }
}
