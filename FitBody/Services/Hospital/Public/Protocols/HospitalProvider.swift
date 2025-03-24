import Foundation

protocol HospitalProvider: AnyObject, Sendable {
    func get(with id: Hospital.ID) async throws -> Hospital
}
