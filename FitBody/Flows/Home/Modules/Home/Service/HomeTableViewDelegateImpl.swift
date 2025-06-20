import UIKit

// MARK: - HomeTableViewDelegateImpl

final class HomeTableViewDelegateImpl: NSObject {
    var sections: [HomeSection] = []
    
    var bookDoctorDidSelect: (() -> Void)?
    var waterIntakeDidSelect: (() -> Void)?
    var doctorDidSelect: ((Doctor.ID) -> Void)?
    var workoutDidSelect: (() -> Void)?
    var dietDidSelect: (() -> Void)?
    var consultationDidSelect: (() -> Void)?
}

// MARK: - UITableViewDelegate

extension HomeTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as DoctorsCell:
            cell.delegate = self
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section].kind {
        case .bookDoctor:
            bookDoctorDidSelect?()
        case .waterIntake:
            waterIntakeDidSelect?()
        case .workout:
            workoutDidSelect?()
        case .diet:
            dietDidSelect?()
        case .consultation:
            consultationDidSelect?()
        case .doctors:
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
        guard let view = view as? HomeSectionHeaderView else {
            return
        }
        
        switch sections[section].kind {
        case .doctors:
            view.configure(with: "Doctors in FitBody")
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .doctors:
            tableView.dequeueReusableHeaderFooterView(HomeSectionHeaderView.self)
        case .bookDoctor, .waterIntake, .workout, .diet, .consultation:
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
        case .doctors:
            doctorItemHeight()
        case .workout:
            isEstimated ? 92 : UITableView.automaticDimension
        case .diet:
            isEstimated ? 160 : UITableView.automaticDimension
        case .consultation:
            isEstimated ? 100 : UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .doctors:
            40
        case .bookDoctor, .waterIntake, .workout, .diet, .consultation:
            .leastNormalMagnitude
        }
    }
    
    private func doctorItemHeight() -> CGFloat {
        let collectionViewHeight = DoctorsCell.getHeight()
        return collectionViewHeight + 8 + 24
    }
}

// MARK: - DoctorsCellDelegate

extension HomeTableViewDelegateImpl: DoctorsCellDelegate {
    func doctorsCell(_ cell: DoctorsCell, didSelectDoctor doctor: DoctorListItem) {
        doctorDidSelect?(doctor.id)
    }
}
