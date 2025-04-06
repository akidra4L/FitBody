import UIKit
import Resolver

// MARK: - DietViewOutput

protocol DietViewOutput: AnyObject {}

// MARK: - DietViewController

final class DietViewController: BaseViewController, DietViewOutput {
    private lazy var mainView = DietView(
        dataSourceImpl: dataSourceImpl,
        delegateImpl: delegateImpl,
        delegate: self
    )
    
    private lazy var dataSourceImpl = DietTableViewDataSourceImpl()
    private lazy var delegateImpl = DietTableViewDelegateImpl()
    
    @Injected private var mealsProvider: MealsProvider
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMeals()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Diet"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func getMeals() {
        mainView.changeLoadingState(to: true)
        Task { [weak self, mealsProvider] in
            defer {
                self?.mainView.changeLoadingState(to: false)
            }
            
            do {
                let meals = try await mealsProvider.get()
                
                self?.configureSections(with: meals)
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func configureSections(with meals: [Meal]) {
        let sections = DietSectionsFactory().make(from: meals)
        
        dataSourceImpl.sections = sections
        delegateImpl.sections = sections
        mainView.reloadData()
    }
}

// MARK: - DietViewDelegate

extension DietViewController: DietViewDelegate {
    func didTapActionButton(in view: DietView) {
        
    }
}
