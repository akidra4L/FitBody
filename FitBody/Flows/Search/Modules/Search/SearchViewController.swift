import UIKit
import SnapKit
import MapKit
import Resolver

// MARK: - SearchViewOutput

protocol SearchViewOutput: AnyObject {
    var hospitalDidSelect: ((Hospital.ID) -> Void)? { get set }
}

// MARK: - SearchViewController

final class SearchViewController: BaseViewController, SearchViewOutput {
    var hospitalDidSelect: ((Hospital.ID) -> Void)?
    
    @Injected private var hospitalMapItemsProvider: HospitalMapItemsProviderImpl
    
    private lazy var mainView = SearchView(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getMapItems()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Search"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getMapItems() {
        Task { [weak self, hospitalMapItemsProvider] in
            do {
                let hospitals = try await hospitalMapItemsProvider.get()
                
                self?.mainView.addAnnotations(with: hospitals)
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func setup() {
        view.addSubview(mainView)
        view.backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabBarHeight)
        }
    }
}

extension SearchViewController: SearchViewDelegate {
    func searchView(_ view: SearchView, didSelectMapItemWithID id: Hospital.ID) {
        hospitalDidSelect?(id)
    }
}
