import CoreLocation

struct Address: Codable, Equatable, Sendable {
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
