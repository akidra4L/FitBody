import UIKit

// MARK: - WorkoutsTableViewDelegateImpl

final class WorkoutsTableViewDelegateImpl: NSObject {
    var sections: [WorkoutsSection] = []
}

// MARK: - UITableViewDelegate

extension WorkoutsTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? WorkoutsSectionHeaderView else {
            return
        }
        
        switch sections[section].kind {
        case .workouts:
            view.configure(with: "What do you want to Train?")
        case .top:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .workouts:
            tableView.dequeueReusableHeaderFooterView(WorkoutsSectionHeaderView.self)
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
        case .top:
            isEstimated ? 208 : UITableView.automaticDimension
        case .workouts:
            UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .workouts:
            40
        case .top:
            .leastNormalMagnitude
        }
    }
}
