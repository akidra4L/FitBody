import UIKit

// MARK: - HomeTableViewDataSourceImpl

final class HomeTableViewDataSourceImpl: NSObject {
    var sections: [HomeSection] = []
}

// MARK: - UITableViewDataSource

extension HomeTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case .bookDoctor:
            return tableView.dequeueReusableCell(HomeBookDoctorCell.self, for: indexPath)
        case .waterIntake:
            let cell: HomeWaterIntakeCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: HomeWaterIntakeViewModel())
            return cell
        case let .doctors(doctors):
            let cell: HomeDoctorsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: doctors)
            return cell
        }
    }
}
