import Resolver

final class DoctorsProviderImpl: DoctorsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [DoctorListItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.doctors.map {
            DoctorListItem(
                id: $0.id,
                lastName: $0.lastName,
                rating: $0.rating,
                illustration: $0.illustration,
                address: $0.hospital.name
            )
        }
    }
    
    func get(with id: Hospital.ID) async throws -> [DoctorListItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.doctors
            .filter { $0.hospital.id == id }
            .map {
                DoctorListItem(
                    id: $0.id,
                    lastName: $0.lastName,
                    rating: $0.rating,
                    illustration: $0.illustration,
                    address: $0.hospital.name
                )
            }
    }
}

