import Resolver

import Foundation

// MARK: - UserProfileProviderImpl

final class UserProfileProviderImpl {
    private let cachedUserProfile = FileStorageWrapper<UserProfile>(path: "User/userProfile.json")
    
    private let networkClient = Resolver.resolve(NetworkClient.self)
}

// MARK: - UserProfileProvider

extension UserProfileProviderImpl: UserProfileProvider {
    var userProfile: UserProfile? {
        cachedUserProfile.value
    }
    
    // TODO: - add relative path
    func get() async throws -> UserProfile {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let userProfile = UserProfile(
            firstName: "Alikhan",
            lastName: "Gubayev",
            email: "alikhan.g@1fit.app",
            gender: .man,
            birthDate: Date(),
            weight: 65,
            height: 170
        )
        
        cachedUserProfile.update(with: userProfile)
        
        return userProfile

//        try await networkClient.get("")
    }
}
