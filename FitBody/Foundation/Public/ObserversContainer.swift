import Foundation

final class ObserversContainer<Observer>: @unchecked Sendable {
    public var isEmpty: Bool {
        allObservers.isEmpty
    }

    private var allObservers: [Observer] {
        lock.critical { observers.allObjects as! [Observer] }
    }

    private let lock = UnfairLock()
    private var observers = NSHashTable<AnyObject>.weakObjects()

    public init() {}

    public func add(_ observer: Observer) {
        lock.critical {
            guard !unsafeContains(observer) else {
                return
            }

            observers.add(observer as AnyObject)
        }

        cleanup()
    }

    public func remove(_ observer: Observer) {
        lock.critical {
            guard unsafeContains(observer) else {
                return
            }

            observers.remove(observer as AnyObject)
        }

        cleanup()
    }

    public func notify(with closure: (Observer) -> Void) {
        allObservers.forEach { closure($0) }
        cleanup()
    }

    private func unsafeContains(_ observer: Observer) -> Bool {
        observers.contains(observer as AnyObject)
    }

    private func cleanup() {
        lock.critical {
            guard observers.allObjects.count < observers.count else {
                return
            }

            let newHashTable = NSHashTable<AnyObject>.weakObjects()
            observers.allObjects.forEach { newHashTable.add($0) }
            observers = newHashTable
        }
    }
}
