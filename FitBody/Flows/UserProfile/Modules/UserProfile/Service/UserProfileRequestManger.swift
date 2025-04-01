import Resolver

final class UserProfileRequestManger: Sendable {
    func getUserProfileIfNeeded() async throws -> UserProfile {
        if let userProfile = userProfileProvider.userProfile {
            return userProfile
        }
        
        return try await userProfileProvider.get()
    }
    
    private let userProfileProvider = Resolver.resolve(UserProfileProvider.self)
}
