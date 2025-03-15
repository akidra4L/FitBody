import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()

            let string = try container.decode(String.self)
            let dateString = string.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)

            if let date = formatter.date(from: dateString) {
                return date
            }

            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            assertionFailure()
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        }
        return decoder
    }

    private nonisolated(unsafe) static let formatter = ISO8601DateFormatter()
    private nonisolated(unsafe) static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter
    }()
}
