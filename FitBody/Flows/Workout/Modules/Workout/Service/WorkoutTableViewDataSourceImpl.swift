import UIKit

// MARK: - WorkoutTableViewDataSourceImpl

final class WorkoutTableViewDataSourceImpl: NSObject {
    var sections: [WorkoutSection] = []
}

// MARK: - UITableViewDataSource

extension WorkoutTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case .top:
            return tableView.dequeueReusableCell(WorkoutTopCell.self, for: indexPath)
        }
    }
    
    
}
