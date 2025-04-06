import UIKit
import SnapKit
import Resolver

// MARK: - WorkoutsViewOutput

protocol WorkoutsViewOutput: AnyObject {}

// MARK: - WorkoutsViewController

final class WorkoutsViewController: BaseViewController, WorkoutsViewOutput {
    private var parameters = WorkoutsParameters()
    
    private lazy var tableView = WorkoutsTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    
    private lazy var dataSourceImpl = WorkoutsTableViewDataSourceImpl()
    private lazy var delegateImpl = WorkoutsTableViewDelegateImpl()
    
    @Injected private var workoutsProvider: WorkoutsProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getWorkouts()
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
                backgroundColor: parameters.isLoaded ? Colors.fillPrimary : Colors.fillBackgroundPrimary,
                foregroundColor: parameters.isLoaded ? Colors.fillInput : Colors.textPrimary
            )
        )
        navigationBar.tintColor = parameters.isLoaded ? Colors.fillInput : Colors.iconPrimary
        navigationItem.title = "Workouts"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getWorkouts() {
        activityIndicatorView.startAnimating()
        Task { [weak self, workoutsProvider] in
            defer {
                self?.activityIndicatorView.stopAnimating()
            }
            
            do {
                self?.parameters.workouts = try await workoutsProvider.get()
                
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
    
    private func setup() {
        [tableView, activityIndicatorView].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func configureSections() {
        let sections = WorkoutsSectionsFactory().make(with: parameters)
        
        dataSourceImpl.sections = sections
        delegateImpl.sections = sections
        tableView.reloadData()
    }
}
