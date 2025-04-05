import UIKit
import SnapKit
import Resolver

// MARK: - WorkoutViewOutput

protocol WorkoutViewOutput: AnyObject {}

// MARK: - WorkoutViewController

final class WorkoutViewController: BaseViewController, WorkoutViewOutput {
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar, with: .transparent)
        navigationItem.title = "Workout"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setup() {
        [activityIndicatorView].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
