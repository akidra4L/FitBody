import Foundation

final class FileStorageWrapper<T: Codable & Equatable & Sendable>: @unchecked Sendable {
    typealias Path = String

    var value: T? {
        lock.critical { _value }
    }

    private var _value: T?

    private let lock = UnfairLock()
    private let disk = Disk()

    private let directory: FileDirectory
    private let path: Path

    init(from directory: FileDirectory = .caches, path: Path) {
        self.directory = directory
        self.path = path

        self._value = try? disk.retrieve(from: directory, at: path, as: T.self)
    }

    func update(with value: T?) {
        guard self.value != value else {
            return
        }

        lock.critical { _value = value }

        if let value {
            try? disk.save(value, to: directory, at: path)
        } else {
            try? disk.remove(from: directory, at: path)
        }
    }
}
