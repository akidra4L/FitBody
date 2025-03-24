import UIKit

// MARK: - HospitalTableViewDataSourceImpl

final class HospitalTableViewDataSourceImpl: NSObject {
    var sections: [HospitalSection] = []
}

// MARK: - UITableViewDataSource

extension HospitalTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case let .top(hospital):
            let cell: HospitalTopCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: HospitalTopViewModel(with: hospital)
            )
            return cell
        case let .doctors(doctors):
            let cell: DoctorsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: doctors)
            return cell
        case .reviews:
            return UITableViewCell()
        }
    }
}
