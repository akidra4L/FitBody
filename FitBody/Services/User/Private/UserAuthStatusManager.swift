import Foundation

// MARK: - UserAuthStatusManager

final class UserAuthStatusManager {
    private let cachedIsAuthenticated = UserDefaultsNonOptionalWrapper(
        key: "isAuthenticated",
        defaultValue: false
    )
}

// MARK: - UserAuthStatusProvider

extension UserAuthStatusManager: UserAuthStatusProvider {
    var isAuthenticated: Bool {
        cachedIsAuthenticated.value
    }
}

// MARK: - UserAuthStatusResetter

extension UserAuthStatusManager: UserAuthStatusResetter {
    func reset() {
        cachedIsAuthenticated.update(with: false)
    }
}

// MARK: - UserAuthStatusSetter

extension UserAuthStatusManager: UserAuthStatusSetter {
    func set() {
        cachedIsAuthenticated.update(with: true)
    }
}
