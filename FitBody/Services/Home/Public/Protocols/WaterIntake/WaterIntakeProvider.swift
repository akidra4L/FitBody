import Foundation

protocol WaterIntakeProvider: AnyObject, Sendable {
    var target: Int? { get }
}
