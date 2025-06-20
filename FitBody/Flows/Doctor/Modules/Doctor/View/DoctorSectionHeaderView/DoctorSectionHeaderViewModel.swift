import Foundation

struct DoctorSectionHeaderViewModel: Sendable {
    typealias Kind = DoctorSection.Kind
    
    var title: String? {
        switch kind {
        case .aboutMe:
            "About me"
        case .review:
            "Reviews"
        case .top, .hospital:
            nil
        }
    }
    
    var isHiddenButton: Bool {
        switch kind {
        case let .review(count):
            count <= 3
        case .aboutMe, .top, .hospital:
            true
        }
    }
    
    private let kind: Kind
    
    init(with kind: Kind) {
        self.kind = kind
    }
}
