import Foundation

protocol PropertyDateFormatter: AnyObject, Sendable {
    func string(from date: Date, withFormat dateFormat: String) -> String
}
