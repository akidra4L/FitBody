import Foundation

protocol HomeDoctorsProvider: AnyObject, Sendable {
    func get() async throws -> [HomeDoctorListItem]
}
