import UIKit

// MARK: - DietTableViewDataSourceImpl

final class DietTableViewDataSourceImpl: NSObject {
    var sections: [DietSection] = []
}

// MARK: - UITableViewDataSource

extension DietTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case .top:
            return tableView.dequeueReusableCell(DietTopCell.self, for: indexPath)
        case let .meal(meal):
            let cell: DietMealCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: DietMealViewModel(with: meal)
            )
            return cell
        }
    }
}
