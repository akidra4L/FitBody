import UIKit
import SnapKit
import Resolver

// MARK: - UserProfileViewOutput

protocol UserProfileViewOutput: AnyObject {}

// MARK: - UserProfileViewController

final class UserProfileViewController: BaseViewController, UserProfileViewOutput {
    private var userProfile: UserProfile?
    
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableView = UserProfileTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    
    private lazy var requestManager = UserProfileRequestManger()
    private lazy var dataSourceImpl = UserProfileTableViewDataSourceImpl()
    private lazy var delegateImpl = UserProfileTableViewDelegateImpl()
    
    @Injected private var userSessionDestroyer: UserSessionDestroyer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupDelegateImpl()
        getUserProfile()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Profile"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getUserProfile() {
        activityIndicatorView.startAnimating()
        Task { [weak self, requestManager] in
            defer {
                self?.activityIndicatorView.stopAnimating()
            }
            
            do {
                self?.userProfile = try await requestManager.getUserProfileIfNeeded()
                
                self?.configureRows()
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func setup() {
        [activityIndicatorView, tableView].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    private func setupDelegateImpl() {
        delegateImpl.quitDidTap = { [weak self] in
            self?.userSessionDestroyer.destroy()
        }
    }
    
    private func configureRows() {
        guard let userProfile else {
            assertionFailure()
            return
        }
        
        let rows: [UserProfileRow] = [
            .info(userProfile),
            .quit
        ]
        
        dataSourceImpl.rows = rows
        delegateImpl.rows = rows
        tableView.reloadData()
    }
}
