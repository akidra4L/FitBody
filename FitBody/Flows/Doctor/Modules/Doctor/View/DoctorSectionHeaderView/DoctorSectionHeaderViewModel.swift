import Foundation

struct DoctorSectionHeaderViewModel: Sendable {
    typealias Kind = DoctorSection.Kind
    
    var title: String? {
        switch kind {
        case .aboutMe:
            "About me"
        case .top:
            nil
        case .review:
            "Reviews"
        }
    }
    
    var isHiddenButton: Bool {
        switch kind {
        case let .review(count):
            count <= 3
        case .aboutMe, .top:
            true
        }
    }
    
    private let kind: Kind
    
    init(with kind: Kind) {
        self.kind = kind
    }
}
