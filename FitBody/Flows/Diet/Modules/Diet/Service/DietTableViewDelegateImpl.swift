import UIKit

// MARK: - DietTableViewDelegateImpl

final class DietTableViewDelegateImpl: NSObject {
    var sections: [DietSection] = []
}

// MARK: - UITableViewDelegate

extension DietTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? DietSectionHeaderView else {
            return
        }
        
        switch sections[section].kind {
        case let .meals(title, count):
            view.configure(with: title, and: "\(count) meals")
        case .top:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .meals:
            tableView.dequeueReusableHeaderFooterView(DietSectionHeaderView.self)
        case .top:
            nil
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        heightForHeaderInSection(tableView, in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeaderInSection(tableView, in: section)
    }
    
    private func heightForRowAt(_ tableView: UITableView, indexPath: IndexPath, isEstimated: Bool) -> CGFloat {
        switch sections[indexPath.section].kind {
        case .top, .meals:
            UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .meals:
            40
        case .top:
            .leastNormalMagnitude
        }
    }
}
