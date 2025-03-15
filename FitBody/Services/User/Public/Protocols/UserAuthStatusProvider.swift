import Foundation

protocol UserAuthStatusProvider: AnyObject, Sendable {
    var isAuthenticated: Bool { get }
}
