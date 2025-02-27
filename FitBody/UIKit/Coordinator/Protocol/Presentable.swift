import UIKit

// MARK: - Presentable

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController
}

// MARK: - UIViewController + Presentable

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController {
        self
    }
}
