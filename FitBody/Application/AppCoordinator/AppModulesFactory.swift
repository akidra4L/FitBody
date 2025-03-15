import UIKit

// MARK: - AppModulesFactory

protocol AppModulesFactory: AnyObject {
    func makeLaunchScreen() -> Presentable & LaunchScreenViewOutput
    func makeTabBar(with viewControllers: [UIViewController]) -> Presentable
}

// MARK: - ModulesFactory + AppModulesFactory

extension ModulesFactory: AppModulesFactory {
    func makeLaunchScreen() -> LaunchScreenViewOutput & Presentable {
        LaunchScreenViewController()
    }
    
    func makeTabBar(with viewControllers: [UIViewController]) -> Presentable {
        TabBarViewController(with: viewControllers)
    }
}
