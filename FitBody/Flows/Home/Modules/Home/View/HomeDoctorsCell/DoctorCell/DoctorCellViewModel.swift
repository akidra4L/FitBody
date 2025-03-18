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
    
    private let doctor: HomeDoctorListItem
    
    init(with doctor: HomeDoctorListItem) {
        self.doctor = doctor
    }
}
