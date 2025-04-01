import UIKit

// MARK: - UserProfileTableViewDelegateImpl

final class UserProfileTableViewDelegateImpl: NSObject {
    var rows: [UserProfileRow] = []
}

// MARK: - UITableViewDelegate

extension UserProfileTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    private func heightForRowAt(_ tableView: UITableView, indexPath: IndexPath, isEstimated: Bool) -> CGFloat {
        switch rows[indexPath.row] {
        case .info:
            UITableView.automaticDimension
        }
    }
}
