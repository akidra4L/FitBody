import Foundation

final class AuthRegisterProviderImpl: AuthRegisterProvider {
    private let _request = Atomic<Request?>(with: nil)
    
    var request: Request? {
        _request.value
    }
    
    func updateMainInfo(firstName: String, lastName: String, email: String, password: String) {
        var request = Request()
        request.firstName = firstName
        request.lastName = lastName
        request.email = email
        request.password = password
        
        _request.update(with: request)
    }
    
    func updateAdditionalInfo(gender: Gender, birthDate: Date, weight: Double, height: Double) {
        guard var value = _request.value else {
            assertionFailure()
            return
        }
        
        value.gender = gender
        value.birthDate = birthDate
        value.weight = weight
        value.height = height
        
        _request.update(with: value)
    }
    
    func updateGoal(with goal: Request.Goal) {
        guard var value = _request.value else {
            assertionFailure()
            return
        }
        
        value.goal = goal
        
        _request.update(with: value)
    }
}
