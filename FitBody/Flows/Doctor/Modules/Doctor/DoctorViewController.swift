import UIKit
import Resolver

// MARK: - DoctorViewOutput

protocol DoctorViewOutput: AnyObject {
    var showMoreReviewsDidTap: (([String]) -> Void)? { get set }
}

// MARK: - DoctorViewController

final class DoctorViewController: BaseViewController, DoctorViewOutput {
    typealias ID = Doctor.ID
    
    var showMoreReviewsDidTap: (([String]) -> Void)?
    
    private var doctor: Doctor?
    private var sections: [DoctorSection] = [] {
        didSet {
            guard oldValue != sections else {
                return
            }
            
            dataSourceImpl.sections = sections
            delegateImpl.sections = sections
            mainView.tableView.reloadData()
        }
    }
    
    private lazy var mainView = DoctorView(
        dataSourceImpl: dataSourceImpl,
        delegateImpl: delegateImpl,
        delegate: self
    )
    
    private lazy var dataSourceImpl = DoctorTableViewDataSourceImpl()
    private lazy var delegateImpl = DoctorTableViewDelegateImpl()
    
    @Injected private var doctorProvider: DoctorProvider
    
    private let id: ID
    
    init(with id: ID) {
        self.id = id
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegateImpl()
        getDoctor()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getDoctor() {
        mainView.changeLoadingState(to: true)
        Task { [weak self, id, doctorProvider] in
            defer {
                self?.mainView.changeLoadingState(to: false)
            }
            
            do {
                self?.doctor = try await doctorProvider.get(with: id)
                
                guard
                    let self,
                    let doctor
                else {
                    return
                }
                
                navigationItem.title = "\(doctor.firstName) \(doctor.lastName)"
                mainView.configure(with: doctor)
                configureSections()
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func configureSections() {
        guard let doctor else {
            return
        }
        
        sections = DoctorSectionsFactory().make(from: doctor)
    }
    
    private func setupDelegateImpl() {
        delegateImpl.showMoreReviewsDidTap = { [weak self] in
            self?.handleShowReviewsTap()
        }
        delegateImpl.readAllDidTap = { [weak self] cell in
            self?.handleReadAllTap(in: cell)
        }
    }
    
    private func handleShowReviewsTap() {
        guard let reviews = doctor?.reviews else {
            assertionFailure()
            return
        }
        
        showMoreReviewsDidTap?(reviews)
    }
    
    private func handleReadAllTap(in cell: UITableViewCell) {
        guard let indexPath = mainView.tableView.indexPath(for: cell) else {
            assertionFailure()
            return
        }
        
        mainView.tableView.performBatchUpdates { [weak self] in
            guard let self else {
                assertionFailure()
                return
            }
            
            dataSourceImpl.aboutState.toggle()
            if case .default = dataSourceImpl.aboutState {
                mainView.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }
            mainView.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - DoctorViewDelegate

extension DoctorViewController: DoctorViewDelegate {
    func didTapActionButton(in view: DoctorView) {}
}
