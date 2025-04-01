import Foundation
import Resolver

struct UserProfileInfoViewModel: Sendable {
    var name: String {
        userProfile.firstName + " " + userProfile.lastName
    }
    
    var birthDateText: String {
        dateFormatter.string(from: userProfile.birthDate, withFormat: "d MMMM yyyy")
    }
    
    var info: [(title: String, subtitle: String)] {
        [
            (
                title: "\(numberFormatter.string(from: userProfile.height, maximumFractionDigits: 0)!)cm",
                subtitle: "Height"
            ),
            (
                title: "\(numberFormatter.string(from: userProfile.weight, maximumFractionDigits: 0)!)kg",
                subtitle: "Weight"
            ),
            (
                title: "\(userProfile.age)yo",
                subtitle: "Age"
            )
        ]
    }
    
    private let dateFormatter = Resolver.resolve(PropertyDateFormatter.self)
    private let numberFormatter = Resolver.resolve(PropertyNumberFormatter.self)
    
    private let userProfile: UserProfile
    
    init(with userProfile: UserProfile) {
        self.userProfile = userProfile
    }
}
