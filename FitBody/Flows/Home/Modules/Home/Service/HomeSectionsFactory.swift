import Foundation

final class HomeSectionsFactory {
    func make(with parameters: HomeParameters) -> [HomeSection] {
        [
            HomeSection(kind: .bookDoctor, rows: [.bookDoctor]),
            HomeSection(kind: .workout, rows: [.workout]),
            HomeSection(kind: .diet, rows: [.diet]),
            HomeSection(kind: .consultation, rows: [.consultation]),
            makeDoctorsSection(from: parameters.doctors)
        ].compactMap { $0 }
    }
    
    private func makeDoctorsSection(from doctors: [DoctorListItem]) -> HomeSection? {
        guard !doctors.isEmpty else {
            return nil
        }
        
        return HomeSection(kind: .doctors, rows: [.doctors(doctors)])
    }
}
