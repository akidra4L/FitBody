import Foundation

protocol DoctorsProvider: Sendable {
    func get() async throws -> [DoctorListItem]
    func get(with id: Hospital.ID) async throws -> [DoctorListItem]
}
