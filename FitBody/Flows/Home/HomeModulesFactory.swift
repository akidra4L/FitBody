import Foundation

protocol HomeModulesFactory: AnyObject {
    func makeConsultation() -> Presentable
    func makeHome() -> Presentable & HomeViewOutput
}

extension ModulesFactory: HomeModulesFactory {
    func makeConsultation() -> Presentable {
        ConsultationViewController()
    }
    
    func makeHome() -> Presentable & HomeViewOutput {
        HomeViewController()
    }
}
