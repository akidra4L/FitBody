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
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 32
        [
            UserProfileInfoCell.self
        ].forEach { tableView.register(cellClass: $0) }
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 32
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
}
