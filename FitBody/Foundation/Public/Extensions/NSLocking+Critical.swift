import Foundation

extension NSLocking {
    public func critical<Result>(_ criticalSection: () throws -> Result) rethrows -> Result {
        lock()
        defer { unlock() }
        return try criticalSection()
    }
}
