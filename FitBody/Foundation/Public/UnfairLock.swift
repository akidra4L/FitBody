import Foundation

// MARK: - UnfairLock

final class UnfairLock {
    private let underlyingLock = os_unfair_lock_t.allocate(capacity: 1)

    public init() {
        underlyingLock.initialize(
            to: os_unfair_lock_s()
        )
    }

    deinit {
        underlyingLock.deinitialize(count: 1)
        underlyingLock.deallocate()
    }

    public func `try`() -> Bool {
        os_unfair_lock_trylock(underlyingLock)
    }
}

// MARK: - NSLocking

extension UnfairLock: NSLocking {
    public func lock() {
        os_unfair_lock_lock(underlyingLock)
    }

    public func unlock() {
        os_unfair_lock_unlock(underlyingLock)
    }
}
