import UIKit

final class DoctorTableViewFactory {
    func make(
        with dataSource: UITableViewDataSource?,
        and delegate: UITableViewDelegate?,
        tableHeaderView: UIView?
    ) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = Colors.fillBackgroundPrimary
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 40
        tableView.register(aClass: DoctorSectionHeaderView.self)
        [
            DoctorAboutCell.self,
            DoctorReviewsCell.self,
            DoctorTopCell.self,
        ].forEach { tableView.register(cellClass: $0) }
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 40
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }
}
