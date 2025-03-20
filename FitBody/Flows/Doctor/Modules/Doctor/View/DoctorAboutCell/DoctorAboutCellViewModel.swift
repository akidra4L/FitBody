import Foundation
import UIKit

struct DoctorAboutCellViewModel: Sendable {
    enum State {
        case `default`
        case expanded
        
        mutating func toggle() {
            switch self {
            case .default:
                self = .expanded
            case .expanded:
                self = .default
            }
        }
    }
    
    var numberOfLines: Int {
        switch state {
        case .default:
            4
        case .expanded:
            0
        }
    }
    
    var buttonTitle: String {
        switch state {
        case .default:
            "Read all"
        case .expanded:
            "Close"
        }
    }
    
    var buttonImage: UIImage? {
        switch state {
        case .default:
            Icons.dropdown16x16
        case .expanded:
            Icons.dropdownUp16x16
        }
    }
    
    let description: String
    private let state: State
    
    init(with description: String, and state: State) {
        self.description = description
        self.state = state
    }
}
