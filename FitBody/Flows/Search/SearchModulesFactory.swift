import Foundation

protocol SearchModulesFactory: AnyObject {
    func makeSearch() -> Presentable & SearchViewOutput
    func makeSearchDetail(with hospitalMapItem: HospitalMapItem) -> Presentable & SearchDetailViewOutput
}

extension ModulesFactory: SearchModulesFactory {
    func makeSearch() -> Presentable & SearchViewOutput {
        SearchViewController()
    }
    
    func makeSearchDetail(with hospitalMapItem: HospitalMapItem) -> Presentable & SearchDetailViewOutput {
        SearchDetailViewController(with: hospitalMapItem)
    }
}
