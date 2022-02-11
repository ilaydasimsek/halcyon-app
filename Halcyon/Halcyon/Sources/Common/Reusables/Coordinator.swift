import UIKit
import OSLog

protocol Coordinatable where Self: Coordinator {
    var navigationController: UINavigationController { get }

    func start()
}

/**
 Abstract base class for app coordination
 - Warning: Should not be initialized on it's own since it's an abstract class and will throw an error upon use
*/
class Coordinator: NSObject, Coordinatable {

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


    func setViewController(as controller: UIViewController, animated: Bool) {
        if animated {
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController.view.layer.add(transition, forKey: nil)
        }

        self.navigationController.setViewControllers([controller], animated: false)
    }
}

// MARK: - Child Coordinator Operations
extension Coordinator {

    final func addChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.append(coordinator)
    }
    
    final func removeChildCoordinator(_ coordinator: Coordinatable) {
        guard let index = childCoordinators.firstIndex(of: coordinator) else {
            Logger().error("Could not remove child coordinator. Coordinator does not exist")
            return
        }
        childCoordinators.remove(at: index)
    }
    
    final func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    final func hasChildCoordinator(_ coordinator: Coordinatable) -> Bool {
        return self.childCoordinators.contains(coordinator)
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
        self.removeChildCoordinator(controller.baseCoordinator)
    }
}

// MARK: - Equatable
extension Coordinator {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
