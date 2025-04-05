import Foundation
import Resolver

// MARK: - UserProfileManager

final class UserProfileManager {
    private let cachedUserProfile = FileStorageWrapper<UserProfile>(path: "User/userProfile.json")
    
    private let networkClient = Resolver.resolve(NetworkClient.self)
}

// MARK: - UserProfileProvider

extension UserProfileManager: UserProfileProvider {
    var userProfile: UserProfile? {
        cachedUserProfile.value
    }
    
    // TODO: - add relative path
    func get() async throws -> UserProfile {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2003
        dateComponents.month = 3
        dateComponents.day = 7
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        
        let userProfile = UserProfile(
            firstName: "Alikhan",
            lastName: "Gubayev",
            email: "alikhan.g@1fit.app",
            gender: .man,
            birthDate: date!,
            weight: 65,
            height: 170
        )
        
        cachedUserProfile.update(with: userProfile)
        
        return userProfile

//        try await networkClient.get("")
    }
}

// MARK: - UserProfileCleaner

extension UserProfileManager: UserProfileCleaner {
    func clean() {
        cachedUserProfile.update(with: nil)
    }
}
