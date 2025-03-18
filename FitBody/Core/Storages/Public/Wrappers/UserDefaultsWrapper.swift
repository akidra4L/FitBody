import Foundation

final class UserDefaultsWrapper<T: Equatable & Sendable>: @unchecked Sendable {
    typealias Key = String

    var value: T? {
        lock.critical { _value }
    }

    private var _value: T?

    private let lock = UnfairLock()
    private let userDefaults = UserDefaults.standard

    private let key: Key

    init(key: Key) {
        self.key = key

        self._value = userDefaults.value(forKey: key) as? T
    }

    func update(with value: T?) {
        guard self.value != value else {
            return
        }

        lock.critical { _value = value }

        if let value {
            userDefaults.set(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
}
