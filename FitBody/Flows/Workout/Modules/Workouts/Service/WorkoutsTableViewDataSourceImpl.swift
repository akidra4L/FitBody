import UIKit

// MARK: - WorkoutsTableViewDataSourceImpl

final class WorkoutsTableViewDataSourceImpl: NSObject {
    var sections: [WorkoutsSection] = []
}

// MARK: - UITableViewDataSource

extension WorkoutsTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case .top:
            return tableView.dequeueReusableCell(WorkoutsTopCell.self, for: indexPath)
        case let .workouts(workout):
            let cell: WorkoutCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: WorkoutCellViewModel(with: workout)
            )
            return cell
        }
    }
    
    
}
