import Resolver

final class AuthManagerImpl: AuthManager {
    private let networkClient = Resolver.resolve(NetworkClient.self)
    
    // TODO: - add relative path
    func login(with request: LoginRequest) async throws {
//        try await networkClient.get("")
    }
    
    // TODO: - add relative path
    func register(with request: RegisterRequest) async throws {
//        try await networkClient.post("")
    }
}
