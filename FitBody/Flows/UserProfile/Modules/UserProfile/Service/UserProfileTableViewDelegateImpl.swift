import UIKit

// MARK: - UserProfileTableViewDelegateImpl

final class UserProfileTableViewDelegateImpl: NSObject {
    var rows: [UserProfileRow] = []
    
    var quitDidTap: (() -> Void)?
}

// MARK: - UITableViewDelegate

extension UserProfileTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch rows[indexPath.row] {
        case .quit:
            quitDidTap?()
        case .info:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    private func heightForRowAt(_ tableView: UITableView, indexPath: IndexPath, isEstimated: Bool) -> CGFloat {
        switch rows[indexPath.row] {
        case .info, .quit:
            UITableView.automaticDimension
        }
    }
}
