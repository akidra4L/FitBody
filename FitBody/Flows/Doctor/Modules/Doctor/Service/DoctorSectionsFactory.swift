import Foundation

final class DoctorSectionsFactory {
    func make(from doctor: Doctor) -> [DoctorSection] {
        [
            DoctorSection(kind: .aboutMe, rows: [.aboutMe(doctor.description)])
        ].compactMap { $0 }
    }
}
