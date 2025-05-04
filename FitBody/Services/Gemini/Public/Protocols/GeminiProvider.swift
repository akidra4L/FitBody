import Foundation

protocol GeminiProvider: AnyObject, Sendable {
    func get(with request: GeminiRequest) async throws -> String?
}
