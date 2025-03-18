import Foundation

protocol SearchModulesFactory: AnyObject {
    func makeSearch() -> Presentable & SearchViewOutput
}

extension ModulesFactory: SearchModulesFactory {
    func makeSearch() -> Presentable & SearchViewOutput {
        SearchViewController()
    }
}
