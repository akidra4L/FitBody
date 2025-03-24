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
    private let coordinatorsFactory: CoordinatorsFactory
    
    init(
        router: Router,
        id: ID,
        modulesFactory: DoctorModulesFactory,
        coordinatorsFactory: CoordinatorsFactory
    ) {
        self.router = router
        self.id = id
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        presentDoctor(with: id)
    }
    
    private func presentDoctor(with id: Doctor.ID) {
        let doctor = modulesFactory.makeDoctor(with: id)
        doctor.showMoreReviewsDidTap = { [weak self] reviews in
            self?.presentDoctorReview(with: reviews)
        }
        doctor.hospitalDidTap = { [weak self] id in
            self?.runHospitalFlow(with: id)
        }
        router.push(doctor) { [onFinish] in
            onFinish?()
        }
    }
    
    private func presentDoctorReview(with reviews: [String]) {
        let doctorReview = modulesFactory.makeDoctorReview(with: reviews)
        router.push(doctorReview)
    }
    
    private func runHospitalFlow(with id: Hospital.ID) {
        let coordinator = coordinatorsFactory.makeHospital(with: router, and: id)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
