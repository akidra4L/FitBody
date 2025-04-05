import UIKit

final class UserProfileTableViewFactory {
    func make(
        with dataSource: UITableViewDataSource,
        and delegate: UITableViewDelegate
    ) -> UITableView {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = Colors.fillBackgroundPrimary
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        [
            UserProfileInfoCell.self,
            UserProfileQuitCell.self
        ].forEach { tableView.register(cellClass: $0) }
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
}
