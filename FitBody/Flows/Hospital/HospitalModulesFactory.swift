import Foundation

protocol HospitalModulesFactory: AnyObject {
    func makeHospital(with id: Hospital.ID) -> Presentable & HospitalViewOutput
}

extension ModulesFactory: HospitalModulesFactory {
    func makeHospital(with id: Hospital.ID) -> Presentable & HospitalViewOutput {
        HospitalViewController(with: id)
    }
}
