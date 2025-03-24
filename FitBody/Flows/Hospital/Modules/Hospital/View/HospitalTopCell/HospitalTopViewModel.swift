import Foundation

struct HospitalTopViewModel: Sendable {
    var banner: URL {
        hospital.banner
    }
    
    var title: String {
        hospital.name
    }
    
    var description: String {
        hospital.description
    }
    
    var ratingViewModel: RatingViewModel {
        RatingViewModel(with: hospital.rating.score)
    }
    
    private let hospital: Hospital
    
    init(with hospital: Hospital) {
        self.hospital = hospital
    }
}
