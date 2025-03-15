import UIKit

extension UICollectionView {
    func register(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }

    func register(viewClass: AnyClass, forSupplementaryViewOfKind kind: String) {
        register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(viewClass)")
    }
}
