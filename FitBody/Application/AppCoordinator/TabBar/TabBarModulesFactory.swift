import UIKit

protocol TabBarModulesFactory: AnyObject {
    func makeTabBar(with viewControllers: [UIViewController]) -> Presentable
}

extension ModulesFactory: TabBarModulesFactory {
    func makeTabBar(with viewControllers: [UIViewController]) -> Presentable {
        TabBarViewController(with: viewControllers)
    }
}
