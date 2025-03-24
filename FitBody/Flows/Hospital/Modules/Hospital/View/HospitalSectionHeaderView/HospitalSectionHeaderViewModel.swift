import Foundation

struct HospitalSectionHeaderViewModel: Sendable {
    typealias Kind = HospitalSection.Kind
    
    var title: String? {
        switch kind {
        case .doctors:
            "Doctors in this Hospital"
        case .reviews:
            "Reviews"
        case .top:
            nil
        }
    }
    
    var isHiddenButton: Bool {
        switch kind {
        case let .reviews(count):
            count <= 3
        case .top, .doctors:
            true
        }
    }
    
    private let kind: Kind
    
    init(with kind: Kind) {
        self.kind = kind
    }
}
