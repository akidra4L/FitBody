import UIKit

// MARK: - DoctorTableViewDataSourceImpl

final class DoctorTableViewDataSourceImpl: NSObject {
    var sections: [DoctorSection] = []
    
    var aboutState = DoctorAboutCellViewModel.State.default
}

// MARK: - UITableViewDataSource

extension DoctorTableViewDataSourceImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rows[indexPath.row] {
        case let .aboutMe(text):
            let cell: DoctorAboutCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: DoctorAboutCellViewModel(
                    with: text,
                    and: aboutState
                )
            )
            return cell
        case let .top(doctor):
            let cell: DoctorTopCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: doctor)
            return cell
        case let .review(reviews):
            let cell: DoctorReviewsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: reviews)
            return cell
        case let .hospital(hospital):
            let cell: DoctorHospitalCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(
                with: DoctorHospitalViewModel(hospital: hospital)
            )
            return cell
        }
    }
}
