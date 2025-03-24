import UIKit

// MARK: - HospitalTableViewDelegateImpl

final class HospitalTableViewDelegateImpl: NSObject {
    var sections: [HospitalSection] = []
    
    var doctorDidSelect: ((Doctor.ID) -> Void)?
}

// MARK: - UITableViewDelegate

extension HospitalTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as DoctorsCell:
            cell.delegate = self
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRowAt(tableView, indexPath: indexPath, isEstimated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? HospitalSectionHeaderView else {
            return
        }
        
        view.configure(
            with: HospitalSectionHeaderViewModel(with: sections[section].kind)
        )
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .doctors, .reviews:
            tableView.dequeueReusableHeaderFooterView(HospitalSectionHeaderView.self)
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
        case .top, .reviews:
            UITableView.automaticDimension
        case .doctors:
            doctorItemHeight()
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .doctors, .reviews:
            40
        case .top:
            .leastNormalMagnitude
        }
    }
    
    private func doctorItemHeight() -> CGFloat {
        let collectionViewHeight = DoctorsCell.getHeight()
        return collectionViewHeight + 8 + 24
    }
}

// MARK: - DoctorsCellDelegate

extension HospitalTableViewDelegateImpl: DoctorsCellDelegate {
    func doctorsCell(_ cell: DoctorsCell, didSelectDoctor doctor: DoctorListItem) {
        doctorDidSelect?(doctor.id)
    }
}
