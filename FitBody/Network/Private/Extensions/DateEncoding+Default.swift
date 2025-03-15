import Alamofire
import Foundation

extension URLEncodedFormEncoder.DateEncoding {
    static var `default`: URLEncodedFormEncoder.DateEncoding {
        let formatting = formatter.string(from:)
        return .custom(formatting)
    }

    private nonisolated(unsafe) static let formatter = ISO8601DateFormatter()
}
