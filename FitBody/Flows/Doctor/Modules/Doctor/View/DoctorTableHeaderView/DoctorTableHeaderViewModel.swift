import Foundation

struct DoctorTableHeaderViewModel: Sendable {
    var illustration: URL {
        doctor.illustration
    }
    
    var title: String {
        "Dr. \(doctor.firstName) \(doctor.lastName)"
    }
    
    var subtitle: String {
        doctor.type
    }
    
    private let doctor: Doctor
    
    init(with doctor: Doctor) {
        self.doctor = doctor
    }
}
