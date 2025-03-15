import UIKit

// MARK: - Router

final class Router: NSObject {
    typealias Completion = () -> Void
    
    private let floatingPanelDelegateImpl = FloatingPanelControllerDelegateDefaultImpl()
    
    private var completions: [UIViewController: Completion] = [:]

    private unowned let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        self.navigationController.delegate = self
    }
    
    func present(
        _ module: Presentable,
        animated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        completion: Completion? = nil
    ) {
        let controller = module.toPresent()
        controller.modalPresentationStyle = modalPresentationStyle
        navigationController.present(controller, animated: animated, completion: completion)
    }
    
    func presentFloatingPanel(
        contentModule: Presentable,
        attributes: FloatingPanelAttributes,
        animated: Bool = true,
        completion: Completion? = nil
    ) {
        let floatingPanelController = FloatingPanelControllerFactory().make(
            with: attributes,
            and: floatingPanelDelegateImpl
        )
        floatingPanelController.set(
            contentViewController: contentModule.toPresent()
        )

        if
            let contentViewController = contentModule as? BaseFloatingPanelContentViewController,
            let scrollView = contentViewController.scrollView
        {
            floatingPanelController.track(scrollView: scrollView)
        }

        completions[floatingPanelController] = completion

        navigationController.present(floatingPanelController, animated: animated)
    }
    
    func push(
        _ module: Presentable,
        animated: Bool = true,
        hideBottomBarWhenPushed: Bool = true,
        completion: Completion? = nil
    ) {
        let controller = module.toPresent()
        guard !(controller is UINavigationController) else {
            assertionFailure()
            return
        }

        if let completion {
            completions[controller] = completion
        }

        controller.hidesBottomBarWhenPushed = hideBottomBarWhenPushed
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func popModule(animated: Bool = true) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismissModule(
        animated: Bool = true,
        completion: Completion? = nil
    ) {
        guard let presentedViewController = navigationController.presentedViewController else {
            return
        }

        if let completion {
            completions[presentedViewController] = completion
        }

        navigationController.dismiss(animated: animated) { [weak self] in
            self?.runCompletion(for: presentedViewController)
        }
    }
    
    func setRootModule(_ module: Presentable, animated: Bool = true) {
        let controller = module.toPresent()
        navigationController.setViewControllers([controller], animated: animated)
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }

        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController)
        else {
            return
        }

        runCompletion(for: poppedViewController)
    }
}

// MARK: - Presentable

extension Router: Presentable {
    public func toPresent() -> UIViewController {
        navigationController
    }
}
