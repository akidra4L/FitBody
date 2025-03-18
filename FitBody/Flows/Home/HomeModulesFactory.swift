import Foundation

protocol HomeModulesFactory: AnyObject {
    func makeHome() -> Presentable & HomeViewOutput
}

extension ModulesFactory: HomeModulesFactory {
    func makeHome() -> Presentable & HomeViewOutput {
        HomeViewController()
    }
}
