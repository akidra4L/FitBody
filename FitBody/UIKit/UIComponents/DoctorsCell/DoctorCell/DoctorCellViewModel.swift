import Foundation

struct DoctorCellViewModel: Sendable {
    var illustration: URL {
        doctor.illustration
    }
    
    var title: String {
        "Dr. \(doctor.lastName)"
    }
    
    var ratingViewModel: RatingViewModel {
        RatingViewModel(with: doctor.rating)
    }
    
    var address: String {
        doctor.address
    }
    
    private let doctor: DoctorListItem
    
    init(with doctor: DoctorListItem) {
        self.doctor = doctor
    }
}
