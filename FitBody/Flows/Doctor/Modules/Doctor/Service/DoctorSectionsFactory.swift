import Foundation

final class DoctorSectionsFactory {
    func make(from doctor: Doctor) -> [DoctorSection] {
        [
            DoctorSection(kind: .top, rows: [.top(doctor)]),
            DoctorSection(kind: .aboutMe, rows: [.aboutMe(doctor.description)]),
            DoctorSection(
                kind: .review(doctor.reviews.count),
                rows: [.review(Array(doctor.reviews.prefix(3)))]
            )
        ].compactMap { $0 }
    }
}
