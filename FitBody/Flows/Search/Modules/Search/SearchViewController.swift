import UIKit

// MARK: - SearchViewOutput

protocol SearchViewOutput: AnyObject {}

// MARK: - SearchViewController

final class SearchViewController: BaseViewController, SearchViewOutput {
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Search"
        navigationItem.largeTitleDisplayMode = .never
    }
}
