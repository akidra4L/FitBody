import UIKit

// MARK: - UserProfileTableViewDataSourceImpl

final class UserProfileTableViewDataSourceImpl: NSObject {
    var rows: [UserProfileRow] = []
}

// MARK: - UITableViewDataSource

extension UserProfileTableViewDataSourceImpl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case let .info(userProfile):
            let cell: UserProfileInfoCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: UserProfileInfoViewModel(with: userProfile)
            )
            return cell
        }
    }
}
