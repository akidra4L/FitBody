import Foundation

protocol DoctorProvider: AnyObject, Sendable {
    func get(with id: Doctor.ID) async throws -> Doctor
}
