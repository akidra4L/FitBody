import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var appCoordinator: Coordinator = {
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            fatalError("rootViewController must be UINavigationController")
        }

        let router = Router(with: navigationController)
        let coordinatorsFactory = CoordinatorsFactory()
        return coordinatorsFactory.makeApp(with: router)
    }()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        
        return true
    }
}
