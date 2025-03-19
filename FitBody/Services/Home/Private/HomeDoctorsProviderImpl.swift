import Foundation
import Resolver

final class HomeDoctorsProviderImpl: HomeDoctorsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [HomeDoctorListItem] {
        return MockDataProvider.doctors.map {
            HomeDoctorListItem(
                id: $0.id,
                lastName: $0.lastName,
                rating: $0.rating,
                illustration: $0.illustration
            )
        }
        
//        try await networkClient.get("")
    }
}
