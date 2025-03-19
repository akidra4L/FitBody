import UIKit

// MARK: - DoctorTableViewDataSourceImpl

final class DoctorTableViewDataSourceImpl: NSObject {
    var sections: [DoctorSection] = []
}

// MARK: - UITableViewDataSource

extension DoctorTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case let .aboutMe(text):
            let cell: DoctorAboutMeCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: text)
            return cell
        }
    }
}
