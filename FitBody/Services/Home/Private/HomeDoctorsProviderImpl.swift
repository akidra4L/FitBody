import Foundation
import Resolver

final class HomeDoctorsProviderImpl: HomeDoctorsProvider {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    func get() async throws -> [HomeDoctorListItem] {
        return [
            HomeDoctorListItem(
                id: 1,
                lastName: "Clarkson",
                rating: 4.9,
                illustration: URL(string: "https://cdn.prod.website-files.com/62d4f06f9c1357a606c3b7ef/65ddf3cdf19abaf5688af2f8_shutterstock_1933145801%20(1).jpg")!
            ),
            HomeDoctorListItem(
                id: 2,
                lastName: "May",
                rating: 4.5,
                illustration: URL(string: "https://familydoctor.org/wp-content/uploads/2018/02/41808433_l.jpg")!
            ),
            HomeDoctorListItem(
                id: 3,
                lastName: "Swan",
                rating: 5,
                illustration: URL(string: "https://www.scripps.org/sparkle-assets/images/new_doctor_fb-32abb9ba141c8223aadebce90782ac68.jpeg")!
            ),
            HomeDoctorListItem(
                id: 4,
                lastName: "Lee",
                rating: 5,
                illustration: URL(string: "https://gp-assets-1.growthplug.com/website_files/5198/Oral_Surgeon_Clarksville_TN__Dr._George_S._Lee.jpg")!
            )
        ]
        
//        try await networkClient.get("")
    }
}
