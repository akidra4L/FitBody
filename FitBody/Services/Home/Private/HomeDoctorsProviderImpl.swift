import Foundation
import Resolver

final class HomeDoctorsProviderImpl: HomeDoctorsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [HomeDoctorListItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return MockDataProvider.doctors.map {
            HomeDoctorListItem(
                id: $0.id,
                lastName: $0.lastName,
                rating: $0.rating,
                illustration: $0.illustration,
                address: $0.hospital.name
            )
        }
        
//        try await networkClient.get("")
    }
}
