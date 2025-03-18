import UIKit

// MARK: - HomeTableViewDelegateImpl

final class HomeTableViewDelegateImpl: NSObject {
    var sections: [HomeSection] = []
    
    var bookDoctorDidSelect: (() -> Void)?
    var waterIntakeDidSelect: (() -> Void)?
}

// MARK: - UITableViewDelegate

extension HomeTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        return
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section].kind {
        case .bookDoctor:
            bookDoctorDidSelect?()
        case .waterIntake:
            waterIntakeDidSelect?()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        return
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .bookDoctor, .waterIntake:
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
        case .bookDoctor:
            UITableView.automaticDimension
        case .waterIntake:
            isEstimated ? 140 : UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .bookDoctor, .waterIntake:
            .leastNormalMagnitude
        }
    }
}
