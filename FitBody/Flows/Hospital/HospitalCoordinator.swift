import UIKit
import Resolver

// MARK: - HospitalCoordinatorOutput

protocol HospitalCoordinatorOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - HospitalCoordinator

final class HospitalCoordinator: Coordinator, HospitalCoordinatorOutput {
    var onFinish: (() -> Void)?
    
    var children: [Coordinator] = []
    
    var router: Router
    private let id: Hospital.ID
    private let modulesFactory: HospitalModulesFactory
    private let coordinatorsFactory: CoordinatorsFactory
    
    init(
        router: Router,
        id: Hospital.ID,
        modulesFactory: HospitalModulesFactory,
        coordinatorsFactory: CoordinatorsFactory
    ) {
        self.router = router
        self.id = id
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        presentHospital()
    }
    
    private func presentHospital() {
        let hospital = modulesFactory.makeHospital(with: id)
        hospital.doctorDidSelect = { [weak self] id in
            self?.runDoctorFlow(with: id)
        }
        router.push(hospital) { [onFinish] in
            onFinish?()
        }
    }
    
    private func runDoctorFlow(with id: Doctor.ID) {
        let coordinator = coordinatorsFactory.makeDoctor(with: router, id: id)
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
