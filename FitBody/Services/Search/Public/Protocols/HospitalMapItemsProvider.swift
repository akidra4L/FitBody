import Foundation

protocol HospitalMapItemsProvider: AnyObject, Sendable {
    func get() async throws -> [HospitalMapItem]
}
