import Foundation

struct DoctorHospitalViewModel: Sendable {
    var title: String {
        hospital.name
    }
    
    var ratingViewModel: RatingViewModel {
        RatingViewModel(with: hospital.rating)
    }
    
    var address: String {
        hospital.address.name
    }
    
    private let hospital: Doctor.Hospital
    
    init(hospital: Doctor.Hospital) {
        self.hospital = hospital
    }
}
