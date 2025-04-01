import Foundation

protocol UserSessionDestroyer: AnyObject, Sendable {
    func destroy()
}
