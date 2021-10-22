import UIKit

/**
 Abstract base class for app coordination
 - Warning: Should not be initialized on it's own since it's an abstract class and will throw an error upon use
*/
class Coordinator: NSObject {

    let navigationController: UINavigationController
    let dependencies: CoordinatorDependencies

    private var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController, dependencies: CoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        preconditionFailure("Start method must overriden by the concrete subclass")
    }


    func setViewController(as controller: UIViewController) {
        self.navigationController.setViewControllers([controller], animated: false)
    }
}

// MARK: - Child Coordinator Operations
extension Coordinator {

    final func addChildCoordinator(_ coordinator: Coordinator) {
        // TODO Make sure add function is always called by throwing an exception
        childCoordinators.append(coordinator)
    }
    
    final func removeChildCoordinator(_ coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else {
            print("Controller does not exist")
            return
        }
        childCoordinators.remove(at: index)
    }
    
    final func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: - Navigation Controller Delegate
extension Coordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(fromViewController) else {
            return
        }

        self.childControllerDidFinish(fromViewController)
    }

    /**
     Will be called when child controller is dismissed, handles the tap of back button.
     */
    private func childControllerDidFinish(_ controller: UIViewController) {
        guard let controller = controller as? ViewController else {
            preconditionFailure("Controllers must always inherit ViewController class")
        }
        self.removeChildCoordinator(controller.coordinator)
    }
}

// MARK: - Equatable
extension Coordinator {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
