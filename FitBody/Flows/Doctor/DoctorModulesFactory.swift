import Foundation

protocol DoctorModulesFactory: AnyObject {
    func makeDoctor(with id: Doctor.ID) -> Presentable & DoctorViewOutput
}

extension ModulesFactory: DoctorModulesFactory {
    func makeDoctor(with id: Doctor.ID) -> Presentable & DoctorViewOutput {
        DoctorViewController(with: id)
    }
}
