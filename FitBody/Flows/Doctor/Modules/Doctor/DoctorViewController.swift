import UIKit
import Resolver

// MARK: - DoctorViewOutput

protocol DoctorViewOutput: AnyObject {}

// MARK: - DoctorViewController

final class DoctorViewController: BaseViewController, DoctorViewOutput {
    typealias ID = Doctor.ID
    
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
}

// MARK: - DoctorViewDelegate

extension DoctorViewController: DoctorViewDelegate {}
