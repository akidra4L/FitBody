import Foundation

protocol AuthRegisterProvider: AnyObject, Sendable {
    typealias Request = RegisterRequest

    var request: Request? { get }
    
    func updateMainInfo(firstName: String, lastName: String, email: String, password: String)
    func updateAdditionalInfo(gender: Gender, birthDate: Date, weight: Double, height: Double)
    func updateGoal(with goal: Request.Goal)
}
