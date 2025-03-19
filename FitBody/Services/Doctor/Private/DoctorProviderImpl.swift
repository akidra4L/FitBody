import Resolver

final class DoctorProviderImpl: DoctorProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get(with id: Doctor.ID) async throws -> Doctor {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard let doctor = MockDataProvider.doctors.first(where: { $0.id == id }) else {
            assertionFailure()
            return MockDataProvider.doctors[0]
        }
        
        return doctor
        
//        try await networkClient.get("")
    }
}
