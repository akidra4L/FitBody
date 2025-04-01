import Foundation
import Resolver

// MARK: - UserSessionManager

final class UserSessionManager {
    private let isUserSessionActive = UserDefaultsNonOptionalWrapper(
        key: "isUserSessionActive",
        defaultValue: false
    )
    
    private let observers = ObserversContainer<Observer>()
    
    private let userProfileCleaner = Resolver.resolve(UserProfileCleaner.self)
}

// MARK: - UserSessionProvider

extension UserSessionManager: UserSessionProvider {
    var isActive: Bool {
        isUserSessionActive.value
    }
    
    func addObserver(_ observer: Observer) {
        observers.add(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers.remove(observer)
    }
    
    private func updateSession(with isActive: Bool) {
        if !isActive {
            userProfileCleaner.clean()
        }
        
        isUserSessionActive.update(with: isActive)
        
        observers.notify { $0.userSessionProvider(self, didChangeUserSession: isActive) }
    }
}

// MARK: - UserSessionCreator

extension UserSessionManager: UserSessionCreator {
    func create() {
        updateSession(with: true)
    }
}

// MARK: - UserSessionDestroyer

extension UserSessionManager: UserSessionDestroyer {
    func destroy() {
        updateSession(with: false)
    }
}
