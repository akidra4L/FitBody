import UIKit
import SnapKit
import Resolver

// MARK: - HomeViewOutput

protocol HomeViewOutput: AnyObject {
    var doctorDidSelect: ((Doctor.ID) -> Void)? { get set }
    var workoutDidSelect: (() -> Void)? { get set }
    var dietDidSelect: (() -> Void)? { get set }
}

// MARK: - HomeViewController

final class HomeViewController: BaseViewController, HomeViewOutput {
    var doctorDidSelect: ((Doctor.ID) -> Void)?
    var workoutDidSelect: (() -> Void)?
    var dietDidSelect: (() -> Void)?
    
    private var parameters = HomeParameters()
    
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableView = HomeTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    
    private lazy var dataSourceImpl = HomeTableViewDataSourceImpl()
    private lazy var delegateImpl = HomeTableViewDelegateImpl()
    
    @Injected private var doctorsProvider: DoctorsProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
    
    private func changeLoadingState(to isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableView.isHidden = isLoading
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
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabBarHeight)
        }
    }
    
    private func setupContent() {
        changeLoadingState(to: true)
        Task { [weak self] in
            defer {
                self?.changeLoadingState(to: false)
            }
            
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
            parameters.doctors = try await doctorsProvider.get()
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
    private func configureSections() {
        let sections = HomeSectionsFactory().make(with: parameters)
        
        dataSourceImpl.sections = sections
        delegateImpl.sections = sections
        tableView.reloadData()
    }
    
    private func setupTableViewDelegateImpl() {
        delegateImpl.bookDoctorDidSelect = { [weak self] in
            self?.handleBookDoctorSelect()
        }
        delegateImpl.doctorDidSelect = { [doctorDidSelect] id in
            doctorDidSelect?(id)
        }
        delegateImpl.workoutDidSelect = { [workoutDidSelect] in
            workoutDidSelect?()
        }
        delegateImpl.dietDidSelect = { [dietDidSelect] in
            dietDidSelect?()
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
