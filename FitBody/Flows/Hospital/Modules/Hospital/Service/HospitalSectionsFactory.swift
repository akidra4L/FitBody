import Foundation

final class HospitalSectionsFactory {
    func make(from parameters: HospitalParameters) -> [HospitalSection] {
        [
            makeTopSection(from: parameters.hospital),
            makeDoctorsSection(from: parameters.doctors)
        ].compactMap { $0 }
    }
    
    private func makeTopSection(from hospital: Hospital?) -> HospitalSection? {
        guard let hospital else {
            return nil
        }
        
        return HospitalSection(kind: .top, rows: [.top(hospital)])
    }
    
    private func makeDoctorsSection(from doctors: [DoctorListItem]) -> HospitalSection? {
        guard !doctors.isEmpty else {
            return nil
        }
        
        return HospitalSection(kind: .doctors, rows: [.doctors(doctors)])
    }
}
