import Foundation

struct DoctorTableHeaderViewModel: Sendable {
    var illustration: URL {
        doctor.illustration
    }
    
    var title: String {
        "Dr. \(doctor.firstName) \(doctor.lastName)"
    }
    
    var subtitle: String {
        guard let hospital = doctor.hospital else {
            return doctor.type
        }
        
        return "\(doctor.type) | \(hospital)"
    }
    
    var ratingViewModel: RatingViewModel {
        RatingViewModel(with: doctor.rating)
    }
    
    var reviewText: String? {
        guard !doctor.reviews.isEmpty else {
            return nil
        }
        
        return "(\(doctor.reviews.count) reviews)"
    }
    
    private let doctor: Doctor
    
    init(with doctor: Doctor) {
        self.doctor = doctor
    }
}
