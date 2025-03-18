import Foundation

protocol PropertyNumberFormatter: AnyObject, Sendable {
    func string(from double: Double) -> String?
}
