import Resolver

final class HospitalMapItemsProviderImpl: HospitalMapItemsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [HospitalMapItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.hospitals.map {
            HospitalMapItem(id: $0.id, address: $0.address)
        }
        
//        try await networkClient.get("")
    }
}
