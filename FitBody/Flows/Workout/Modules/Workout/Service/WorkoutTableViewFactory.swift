import UIKit

final class WorkoutTableViewFactory {
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
        tableView.estimatedSectionHeaderHeight = 40
        [
            WorkoutTopCell.self
        ].forEach { tableView.register(cellClass: $0) }
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 40
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
}
