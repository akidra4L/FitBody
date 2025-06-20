import UIKit

final class CoordinatorsFactory {
    func makeApp(with router: Router) -> Coordinator {
        AppCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeAuth(with router: Router, state: AuthState) -> Coordinator & AuthCoordinatorOutput {
        AuthCoordinator(
            router: router,
            state: state,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeDoctor(with router: Router, id: Doctor.ID) -> Coordinator & DoctorCoordinatorOutput {
        DoctorCoordinator(
            router: router,
            id: id,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
    
    func makeTabBar(with router: Router) -> Coordinator {
        TabBarCoordinator(
            router: router,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
    
    func makeHome(with router: Router) -> Coordinator {
        HomeCoordinator(
            router: router,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
    
    func makeOnboarding(with router: Router) -> Coordinator & OnboardingCoordinatorOutput {
        OnboardingCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeSearch(with router: Router) -> Coordinator {
        SearchCoordinator(
            router: router,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
    
    func makeStartupScenario(
        with router: Router,
        and launchInstruction: StartupScenarioLaunchInstruction
    ) -> Coordinator & StartupScenarioCoordinatorOutput {
        StartupScenarioCoordinator(
            router: router,
            launchInstruction: launchInstruction,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeHospital(
        with router: Router,
        and id: Hospital.ID
    ) -> Coordinator & HospitalCoordinatorOutput  {
        HospitalCoordinator(
            router: router,
            id: id,
            modulesFactory: ModulesFactory(),
            coordinatorsFactory: CoordinatorsFactory()
        )
    }
    
    func makeUserProfile(with router: Router) -> Coordinator & UserProfileCoordinatorOutput {
        UserProfileCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeWorkout(with router: Router) -> Coordinator & WorkoutCoordinatorOutput {
        WorkoutCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
    
    func makeDiet(with router: Router) -> Coordinator & DietCoordinatorOutput {
        DietCoordinator(
            router: router,
            modulesFactory: ModulesFactory()
        )
    }
}
