import Foundation

protocol AuthModulesFactory: AnyObject {
    func makeAuth(with state: AuthState) -> Presentable & AuthViewOutput
}

extension ModulesFactory: AuthModulesFactory {
    func makeAuth(with state: AuthState) -> Presentable & AuthViewOutput {
        AuthViewController(with: state)
    }
}
