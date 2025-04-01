import Foundation

// MARK: - UserSessionProviderObserver

protocol UserSessionProviderObserver: AnyObject, Sendable {
    func userSessionProvider(_ provider: UserSessionProvider, didChangeUserSession isActive: Bool)
}

// MARK: - UserSessionProvider

protocol UserSessionProvider: AnyObject, Sendable {
    typealias Observer = UserSessionProviderObserver
    
    var isActive: Bool { get }
    
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
}
