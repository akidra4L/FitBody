import UIKit

// MARK: - WorkoutTableViewDelegateImpl

final class WorkoutTableViewDelegateImpl: NSObject {
    var sections: [WorkoutSection] = []
}

// MARK: - UITableViewDelegate

extension WorkoutTableViewDelegateImpl: UITableViewDelegate {
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
        guard let view = view as? WorkoutSectionHeaderView else {
            return
        }
        
        switch sections[section].kind {
        case .exercises:
            view.configure(with: "Exercises")
        case let .equipments(count):
            view.configure(with: "You’ll Need", and: "\(count) items")
        case .top, .info:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .exercises, .equipments:
            tableView.dequeueReusableHeaderFooterView(WorkoutSectionHeaderView.self)
        case .top, .info:
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
        case .equipments:
            equipementItemHeight()
        case .top, .info, .exercises:
            UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .exercises, .equipments:
            40
        case .top, .info:
            .leastNormalMagnitude
        }
    }
    
    private func equipementItemHeight() -> CGFloat {
        148 + 8 + 24
    }
}
