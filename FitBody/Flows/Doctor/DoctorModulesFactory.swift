import Foundation

protocol DoctorModulesFactory: AnyObject {
    func makeDoctor(with id: Doctor.ID) -> Presentable & DoctorViewOutput
    func makeDoctorReview(with reviews: [String]) -> Presentable
}

extension ModulesFactory: DoctorModulesFactory {
    func makeDoctor(with id: Doctor.ID) -> Presentable & DoctorViewOutput {
        DoctorViewController(with: id)
    }
    
    func makeDoctorReview(with reviews: [String]) -> Presentable {
        DoctorReviewViewController(with: reviews)
    }
}
