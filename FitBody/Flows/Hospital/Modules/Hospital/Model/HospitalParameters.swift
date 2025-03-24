import Foundation

struct HospitalParameters: Sendable {
    var hospital: Hospital?
    var doctors: [DoctorListItem] = []
}
