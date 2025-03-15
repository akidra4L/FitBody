import Foundation

// MARK: - Disk

final class Disk: @unchecked Sendable {
    typealias Path = String

    private let fileManager = FileManager.default

    func retrieve<T: Decodable>(
        from directory: FileDirectory,
        at path: Path,
        as type: T.Type
    ) throws -> T {
        if path.hasSuffix("/") {
            throw makeInvalidFileNameForStructsError()
        }

        do {
            let url = try getExistingFileURL(with: directory, and: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error
        }
    }

    func save(
        _ value: Encodable,
        to directory: FileDirectory,
        at path: Path
    ) throws {
        if path.hasSuffix("/") {
            throw makeInvalidFileNameForStructsError()
        }
        do {
            let url = try makeURL(with: directory, and: path)
            let data = try JSONEncoder().encode(value)
            try makeSubfoldersBeforeCreatingFile(at: url)
            try data.write(to: url, options: .atomic)
        } catch {
            throw error
        }
    }

    func remove(
        from directory: FileDirectory,
        at path: Path
    ) throws {
        do {
            let url = try getExistingFileURL(with: directory, and: path)
            try fileManager.removeItem(at: url)
        } catch {
            throw error
        }
    }
}

// MARK: - URL

extension Disk {
    private func getExistingFileURL(with directory: FileDirectory, and path: Path) throws -> URL {
        do {
            let url = try makeURL(with: directory, and: path)
            if fileManager.fileExists(atPath: url.path) {
                return url
            }

            throw makeError(
                with: .noFileFound,
                description: "Could not find an existing file or folder at \(url.path).",
                failureReason: "There is no existing file or folder at \(url.path)",
                recoverySuggestion: "Check if a file or folder exists before trying to commit an operation on it."
            )
        } catch {
            throw error
        }
    }

    private func makeSubfoldersBeforeCreatingFile(at url: URL) throws {
        do {
            let subfolderURL = url.deletingLastPathComponent()
            var subfolderExists = false
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: subfolderURL.path, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    subfolderExists = true
                }
            }
            if !subfolderExists {
                try fileManager.createDirectory(at: subfolderURL, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            throw error
        }
    }

    private func makeURL(with directory: FileDirectory, and path: Path) throws -> URL {
        let filePrefix = "file://"
        var validPath: String?

        do {
            validPath = try getValidFilePath(from: path)
        } catch {
            throw error
        }

        let searchPathDirectory = makeSearchDirectory(from: directory)

        if var url = fileManager.urls(for: searchPathDirectory, in: .userDomainMask).first {
            if let validPath {
                url = url.appendingPathComponent(validPath, isDirectory: false)
            }

            if url.absoluteString.lowercased().prefix(filePrefix.count) != filePrefix {
                let fixedURLString = filePrefix + url.absoluteString
                url = URL(string: fixedURLString)!
            }
            return url
        }

        throw makeError(
            with: .couldNotAccessUserDomainMask,
            description: "Could not create URL for \(directory.pathDescription)/\(validPath ?? "")",
            failureReason: "Could not get access to the file system's user domain mask.",
            recoverySuggestion: "Use a different directory."
        )
    }

    private func getValidFilePath(from originalString: String) throws -> Path {
        var invalidCharacters = CharacterSet(charactersIn: ":")
        invalidCharacters.formUnion(.newlines)
        invalidCharacters.formUnion(.illegalCharacters)
        invalidCharacters.formUnion(.controlCharacters)
        let pathWithoutIllegalCharacters = originalString.components(separatedBy: invalidCharacters).joined()
        let validFileName = removeSlashesAtBeginning(of: pathWithoutIllegalCharacters)

        guard !validFileName.isEmpty, validFileName != "." else {
            throw makeError(
                with: .invalidFileName,
                description: "\(originalString) is an invalid file name.",
                failureReason: "Cannot write/read a file with the name \(originalString) on disk.",
                recoverySuggestion: "Use another file name with alphanumeric characters."
            )
        }

        return validFileName
    }

    private func removeSlashesAtBeginning(of string: String) -> String {
        var string = string

        if string.prefix(1) == "/" {
            string.remove(at: string.startIndex)
        }

        if string.prefix(1) == "/" {
            string = removeSlashesAtBeginning(of: string)
        }

        return string
    }

    private func makeSearchDirectory(from directory: FileDirectory) -> FileManager.SearchPathDirectory {
        switch directory {
        case .documents:
            .documentDirectory
        case .caches:
            .cachesDirectory
        }
    }
}

// MARK: - Error

extension Disk {
    private enum ErrorCode: Int {
        case noFileFound = 0
        case serialization = 1
        case deserialization = 2
        case invalidFileName = 3
        case couldNotAccessTemporaryDirectory = 4
        case couldNotAccessUserDomainMask = 5
        case couldNotAccessSharedContainer = 6
    }

    private func makeError(
        with errorCode: ErrorCode,
        description: String?,
        failureReason: String?,
        recoverySuggestion: String?
    ) -> Error {
        let errorInfo: [String: Any] = [
            NSLocalizedDescriptionKey: description ?? "",
            NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion ?? "",
            NSLocalizedFailureReasonErrorKey: failureReason ?? ""
        ]
        return NSError(domain: "DiskErrorDomain", code: errorCode.rawValue, userInfo: errorInfo) as Error
    }

    private func makeInvalidFileNameForStructsError() -> Error {
        // swiftlint:disable line_length
        makeError(
            with: .invalidFileName,
            description: "Cannot save/retrieve the Codable struct without a valid file name. Codable structs are not saved as multiple files in a folder, but rather as one JSON file. If you already successfully saved Codable struct(s) to your folder name, try retrieving it as a file named 'Folder' instead of as a folder 'Folder/'",
            failureReason: "Disk does not save structs or arrays of structs as multiple files to a folder like it does UIImages or Data.",
            recoverySuggestion: "Save your struct or array of structs as one file that encapsulates all the data (i.e. \"multiple-messages.json\")"
        )
        // swiftlint:enable line_length
    }
}

// MARK: - FileDirectory + PathDescription

extension FileDirectory {
    fileprivate var pathDescription: String {
        switch self {
        case .documents:
            "<Application_Home>/Documents"
        case .caches:
            "<Application_Home>/Library/Caches"
        }
    }
}
