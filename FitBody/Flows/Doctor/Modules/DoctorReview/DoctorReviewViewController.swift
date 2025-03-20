import UIKit

// MARK: - DoctorReviewViewController

final class DoctorReviewViewController: BaseViewController {
    private lazy var tableView = makeTableView()
    
    private let reviews: [String]
    
    init(with reviews: [String]) {
        self.reviews = reviews
        super.init()
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Reviews"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = Colors.fillBackgroundPrimary
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(cellClass: DoctorReviewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
}

// MARK: - UITableViewDataSource

extension DoctorReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DoctorReviewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: reviews[indexPath.row])
        return cell
    }
}
