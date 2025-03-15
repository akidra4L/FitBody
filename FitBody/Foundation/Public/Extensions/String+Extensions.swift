import Foundation

// MARK: - String + nilIfEmpty

extension String {
    public var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}

// MARK: - String + ReplacingOccurences

extension String {
    public func replacingOccurrences(of strings: [String], with replacement: String) -> String {
        var newString = self
        strings.forEach { newString = newString.replacingOccurrences(of: $0, with: replacement) }
        return newString
    }
}
