import Foundation

protocol DietModulesFactory: AnyObject {
    func makeDiet() -> Presentable & DietViewOutput
}

extension ModulesFactory: DietModulesFactory {
    func makeDiet() -> Presentable & DietViewOutput {
        DietViewController()
    }
}
