import Foundation

protocol UserProfileProvider: AnyObject, Sendable {
    var userProfile: UserProfile? { get }
    
    func get() async throws -> UserProfile
}
