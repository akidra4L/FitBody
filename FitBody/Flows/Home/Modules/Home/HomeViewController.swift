import UIKit
import SnapKit
import Resolver

// MARK: - HomeViewOutput

protocol HomeViewOutput: AnyObject {}

// MARK: - HomeViewController

final class HomeViewController: BaseViewController, HomeViewOutput {
    private var parameters = HomeParameters()
    private var sections: [HomeSection] = [] {
        didSet {
            guard oldValue != sections else {
                return
            }
            
            dataSourceImpl.sections = sections
            delegateImpl.sections = sections
            tableView.reloadData()
        }
    }
    
    private lazy var tableView = HomeTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    
    private lazy var dataSourceImpl = HomeTableViewDataSourceImpl()
    private lazy var delegateImpl = HomeTableViewDelegateImpl()
    
    @Injected private var homeDoctorsProvider: HomeDoctorsProvider
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        setupTableViewDelegateImpl()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupContent() {
        Task { [weak self] in
            await self?.setupRequiredData()
            
            self?.configureSections()
        }
    }
    
    private func setupRequiredData() async {
        async let doctors: Void = getDoctors()
        
        await doctors
    }
    
    private func getDoctors() async {
        do {
            parameters.doctors = try await homeDoctorsProvider.get()
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
    private func configureSections() {
        sections = HomeSectionsFactory().make(with: parameters)
    }
    
    private func setupTableViewDelegateImpl() {
        delegateImpl.bookDoctorDidSelect = { [weak self] in
            self?.handleBookDoctorSelect()
        }
    }
    
    private func handleBookDoctorSelect() {
        let indexData = ["selectedTabBarIndex": 1]
        NotificationCenter.default.post(
            name: Notification.Name("changeTabBarIndex"),
            object: nil,
            userInfo: indexData
        )
    }
}
