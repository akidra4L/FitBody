import UIKit

extension CALayer {
    public func applyShadow(
        opacity: Float = 0,
        offset: CGSize = .zero,
        blur: CGFloat = 0,
        spread: CGFloat = 0
    ) {
        shadowOffset = offset
        shadowOpacity = opacity

        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }

        shadowRadius = blur / 2
    }
}
