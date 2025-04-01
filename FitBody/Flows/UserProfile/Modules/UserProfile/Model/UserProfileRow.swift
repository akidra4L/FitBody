import Foundation

enum UserProfileRow: Equatable, Sendable {
    case info(UserProfile)
    case quit
}
