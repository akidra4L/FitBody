import UIKit
import Resolver

// MARK: - WorkoutViewOutput

protocol WorkoutViewOutput: AnyObject {}

// MARK: - WorkoutViewController

final class WorkoutViewController: BaseViewController, WorkoutViewOutput {
    private lazy var parameters = WorkoutParameters(with: workoutListItem)
    
    private lazy var mainView = WorkoutView(with: dataSourceImpl, and: delegateImpl)
    
    private lazy var dataSourceImpl = WorkoutTableViewDataSourceImpl(with: parameters)
    private lazy var delegateImpl = WorkoutTableViewDelegateImpl()
    
    @Injected private var workoutProvider: WorkoutProvider
    
    private let workoutListItem: WorkoutListItem
    
    init(with workoutListItem: WorkoutListItem) {
        self.workoutListItem = workoutListItem
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWorkout()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(
            navigationBar: navigationBar,
            with: .default(
                needsToDisplayShadow: false,
                backgroundColor: parameters.isLoaded ? Colors.fillPrimary : Colors.fillBackgroundPrimary
            )
        )
        navigationBar.tintColor = parameters.isLoaded ? Colors.fillInput : Colors.iconPrimary
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getWorkout() {
        mainView.changeLoadingState(to: true)
        Task { [weak self, id = workoutListItem.id, workoutProvider] in
            defer {
                self?.mainView.changeLoadingState(to: false)
            }
            
            do {
                self?.parameters.workout = try await workoutProvider.get(with: id)
                
                guard let self else {
                    return
                }
                
                parameters.isLoaded = true
                configureNavigationBar()
                configureSections()
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func configureSections() {
        let sections = WorkoutSectionsFactory().make(from: parameters)
        
        dataSourceImpl.sections = sections
        delegateImpl.sections = sections
        mainView.reloadData()
    }
}
