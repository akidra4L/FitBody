import Foundation

protocol AuthModulesFactory: AnyObject {
    func makeAuth(with state: AuthState) -> Presentable & AuthViewOutput
    func makeAuthSuccess(with name: String) -> Presentable & AuthSuccessViewOutput
    func makeGoal() -> Presentable & GoalViewOutput
}

extension ModulesFactory: AuthModulesFactory {
    func makeAuth(with state: AuthState) -> Presentable & AuthViewOutput {
        AuthViewController(with: state)
    }
    
    func makeAuthSuccess(with name: String) -> Presentable & AuthSuccessViewOutput {
        AuthSuccessViewController(with: name)
    }
    
    func makeGoal() -> Presentable & GoalViewOutput {
        GoalViewController()
    }
}
