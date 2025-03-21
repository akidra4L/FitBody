import Foundation

struct DoctorTableHeaderViewModel: Sendable {
    var illustration: URL {
        doctor.illustration
    }
    
    var title: String {
        "Dr. \(doctor.firstName) \(doctor.lastName)"
    }
    
    var subtitle: String {
        "\(doctor.type) | \(doctor.hospital.name)"
    }
    
    var address: String {
        doctor.hospital.address.name
    }
    
    private let doctor: Doctor
    
    init(with doctor: Doctor) {
        self.doctor = doctor
    }
}
