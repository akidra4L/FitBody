import Foundation

protocol DoctorOnboardingProvider: AnyObject, Sendable {
    var didSee: Bool { get }
}
