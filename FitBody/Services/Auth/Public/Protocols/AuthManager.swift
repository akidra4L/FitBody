import Foundation

protocol AuthManager: AnyObject, Sendable {
    func login(with request: LoginRequest) async throws
    func register(with request: RegisterRequest) async throws
}
