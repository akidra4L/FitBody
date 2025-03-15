import Foundation

final class UserDefaultsNonOptionalWrapper<T: Equatable & Sendable>: @unchecked Sendable {
    typealias Key = String

    var value: T {
        lock.critical { _value }
    }

    private var _value: T

    private let lock = UnfairLock()
    private let userDefaults = UserDefaults.standard

    private let key: Key
    private let defaultValue: T

    init(key: Key, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue

        self._value = userDefaults.value(forKey: key) as? T ?? defaultValue
    }

    func update(with value: T) {
        guard self.value != value else {
            return
        }

        lock.critical { _value = value }

        userDefaults.set(value, forKey: key)
    }
}
