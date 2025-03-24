import UIKit
import Resolver

// MARK: - HospitalViewOutput

protocol HospitalViewOutput: AnyObject {
    var doctorDidSelect: ((Doctor.ID) -> Void)? { get set }
}

// MARK: - HospitalViewController

final class HospitalViewController: BaseViewController, HospitalViewOutput {
    var doctorDidSelect: ((Doctor.ID) -> Void)?
    
    private var parameters = HospitalParameters()
    
    private lazy var mainView = HospitalView(with: dataSourceImpl, and: delegateImpl)
    
    private lazy var dataSourceImpl = HospitalTableViewDataSourceImpl()
    private lazy var delegateImpl = HospitalTableViewDelegateImpl()
    
    @Injected private var hospitalProvider: HospitalProvider
    @Injected private var doctorsProvider: DoctorsProvider
    
    private let id: Hospital.ID
    
    init(with id: Hospital.ID) {
        self.id = id
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegateImpl()
        setupContent()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureSections() {
        let sections = HospitalSectionsFactory().make(from: parameters)
        
        dataSourceImpl.sections = sections
        delegateImpl.sections = sections
        mainView.reloadData()
    }
    
    private func setupDelegateImpl() {
        delegateImpl.doctorDidSelect = { [doctorDidSelect] id in
            doctorDidSelect?(id)
        }
    }
    
    private func setupContent() {
        mainView.changeLoadingState(to: true)
        Task { [weak self] in
            defer {
                self?.mainView.changeLoadingState(to: false)
            }
            
            await self?.setupRequiredData()
            
            self?.configureSections()
        }
    }
    
    private func setupRequiredData() async {
        async let hospital: Void = getHospital()
        async let doctors: Void = getDoctors()
        
        await hospital
        await doctors
    }
    
    private func getHospital() async {
        do {
            let hospital = try await hospitalProvider.get(with: id)
            
            navigationItem.title = hospital.name
            parameters.hospital = hospital
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
    private func getDoctors() async {
        do {
            parameters.doctors = try await doctorsProvider.get(with: id)
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
}
