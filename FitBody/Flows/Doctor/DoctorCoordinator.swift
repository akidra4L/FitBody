import Foundation

// MARK: - DoctorCoordinatorOutput

protocol DoctorCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - DoctorCoordinator

final class DoctorCoordinator: Coordinator, DoctorCoordinatorOutput {
    typealias ID = Doctor.ID
    
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let id: ID
    private let modulesFactory: DoctorModulesFactory
    
    init(
        router: Router,
        id: ID,
        modulesFactory: DoctorModulesFactory
    ) {
        self.router = router
        self.id = id
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        presentDoctor(with: id)
    }
    
    private func presentDoctor(with id: Doctor.ID) {
        let doctor = modulesFactory.makeDoctor(with: id)
        doctor.showMoreReviewsDidTap = { [weak self] reviews in
            self?.presentDoctorReview(with: reviews)
        }
        router.push(doctor) { [onFinish] in
            onFinish?()
        }
    }
    
    private func presentDoctorReview(with reviews: [String]) {
        let doctorReview = modulesFactory.makeDoctorReview(with: reviews)
        router.push(doctorReview)
    }
}
