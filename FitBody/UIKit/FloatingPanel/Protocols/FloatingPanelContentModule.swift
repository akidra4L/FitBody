import UIKit

protocol FloatingPanelContentModule: AnyObject, Presentable {
    var contentLayout: UILayoutGuide { get }
}
