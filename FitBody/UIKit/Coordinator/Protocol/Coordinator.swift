import UIKit

// MARK: - Coordinator

protocol Coordinator: AnyObject {
    var router: Router { get }
    var children: [Coordinator] { get set }
    
    func start()
}

// MARK: - Dependency Methods

extension Coordinator {
    func addDependency(_ coordinator: Coordinator) {
        guard !children.contains(where: { $0 === coordinator }) else {
            assertionFailure()
            return
        }

        children.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
            let coordinator,
            !children.isEmpty
        else {
            return
        }

        coordinator.children.forEach { coordinator.removeDependency($0) }
        children.removeAll { $0 === coordinator }
    }

    func removeAll() {
        router.dismissModule(animated: false)
        children.forEach { removeDependency($0) }
    }
}
