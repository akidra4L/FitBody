import UIKit

// MARK: - DoctorTableViewDelegateImpl

final class DoctorTableViewDelegateImpl: NSObject {
    var sections: [DoctorSection] = []
    
    var showMoreReviewsDidTap: (() -> Void)?
    var readAllDidTap: ((_ cell: UITableViewCell) -> Void)?
    var hospitalDidTap: (() -> Void)?
}

// MARK: - UITableViewDelegate

extension DoctorTableViewDelegateImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as DoctorAboutCell:
            cell.delegate = self
        case let cell as DoctorHospitalCell:
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
        guard let view = view as? DoctorSectionHeaderView else {
            return
        }
        
        view.configure(
            with: DoctorSectionHeaderViewModel(with: sections[section].kind)
        )
        view.delegate = self
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].kind {
        case .aboutMe, .review:
            tableView.dequeueReusableHeaderFooterView(DoctorSectionHeaderView.self)
        case .top, .hospital:
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
        case .aboutMe, .review, .hospital:
            UITableView.automaticDimension
        case .top:
            isEstimated ? 108 : UITableView.automaticDimension
        }
    }
    
    private func heightForHeaderInSection(_ tableView: UITableView, in section: Int) -> CGFloat {
        switch sections[section].kind {
        case .aboutMe, .review:
            40
        case .top, .hospital:
            .leastNormalMagnitude
        }
    }
}

// MARK: - DoctorSectionHeaderViewDelegate

extension DoctorTableViewDelegateImpl: DoctorSectionHeaderViewDelegate {
    func didTapActionButton(in view: DoctorSectionHeaderView) {
        showMoreReviewsDidTap?()
    }
}

// MARK: - DoctorAboutMeCellDelegate

extension DoctorTableViewDelegateImpl: DoctorAboutCellDelegate {
    func didTapActionButton(in cell: DoctorAboutCell) {
        readAllDidTap?(cell)
    }
}

// MARK: - DoctorHospitalCellDelegate

extension DoctorTableViewDelegateImpl: DoctorHospitalCellDelegate {
    func didTapContainerView(in cell: DoctorHospitalCell) {
        hospitalDidTap?()
    }
}
