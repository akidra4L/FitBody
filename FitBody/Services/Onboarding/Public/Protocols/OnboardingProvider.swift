import Foundation

protocol OnboardingProvider: AnyObject, Sendable {
    var didSee: Bool { get }
}
