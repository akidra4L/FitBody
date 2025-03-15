import Foundation

// MARK: - PropertyDateFormatterImpl

final class PropertyDateFormatterImpl: PropertyDateFormatter {
    func string(from date: Date, withFormat dateFormat: String) -> String {
        let formatter = DateFormatter(dateFormat: dateFormat)
        return formatter.string(from: date)
    }
}

// MARK: - DateFormatter + Convenience Init

extension DateFormatter {
    fileprivate convenience init(dateFormat: String) {
        self.init()

        self.dateFormat = dateFormat
        self.setLocalizedDateFormatFromTemplate(dateFormat)
        self.timeZone = .utc
    }
}
