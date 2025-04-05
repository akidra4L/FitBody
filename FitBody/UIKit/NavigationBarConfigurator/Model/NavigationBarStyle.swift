import UIKit

enum NavigationBarStyle: Equatable, Sendable {
    case `default`(
        needsToDisplayShadow: Bool = true,
        backgroundColor: UIColor = Colors.fillBackgroundPrimary,
        foregroundColor: UIColor = Colors.textPrimary
    )
    case transparent
}
