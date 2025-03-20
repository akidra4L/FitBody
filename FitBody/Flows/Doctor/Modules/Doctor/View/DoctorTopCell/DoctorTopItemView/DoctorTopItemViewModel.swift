import UIKit
import Resolver

struct DoctorTopItemViewModel: Sendable {
    enum Kind: CaseIterable {
        case yearsExpert
        case rating
        case reviews
    }
    
    var icon: UIImage? {
        switch kind {
        case .yearsExpert:
            Icons.graph24x24
        case .rating:
            UIImage(systemName: "star.fill")
        case .reviews:
            Icons.review24x24
        }
    }
    
    var title: String {
        switch kind {
        case .yearsExpert:
            "\(doctor.yearsExpert)+"
        case .rating:
            ratingFormatter.string(from: doctor.rating)
        case .reviews:
            "\(doctor.reviews.count)"
        }
    }
    
    var subtitle: String {
        switch kind {
        case .yearsExpert:
            "Years expert"
        case .rating:
            "Rating"
        case .reviews:
            "Reviews"
        }
    }
    
    private let ratingFormatter = Resolver.resolve(RatingFormatter.self)
    
    private let doctor: Doctor
    private let kind: Kind
    
    init(with doctor: Doctor, and kind: Kind) {
        self.doctor = doctor
        self.kind = kind
    }
}
