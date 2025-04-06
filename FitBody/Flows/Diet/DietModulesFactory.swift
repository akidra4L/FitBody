import Foundation

protocol DietModulesFactory: AnyObject {
    func makeDiet() -> Presentable & DietViewOutput
    func makeMealAdd() -> Presentable & MealAddViewOutput
}

extension ModulesFactory: DietModulesFactory {
    func makeDiet() -> Presentable & DietViewOutput {
        DietViewController()
    }
    
    func makeMealAdd() -> Presentable & MealAddViewOutput {
        MealAddViewController()
    }
}
