import UIKit

class AuthenticationCoordinator: Coordinator {
    var onComplete: ((_ success: Bool) -> Void)?

    convenience init(navigationController: UINavigationController,
         dependencies: CoordinatorDependencies,
                     onComplete: ((_ success: Bool) -> Void)?) {
        self.init(navigationController: navigationController,
                   dependencies: dependencies)
        self.onComplete = onComplete
    }

    private override init(navigationController: UINavigationController,
                          dependencies: CoordinatorDependencies) {
        super.init(navigationController: navigationController,
                   dependencies: dependencies)
    }

    override func start() {
        self.setViewController(as: dependencies.makeEntryViewController(coordinator: self))
    }

    func startLogin() {
        let controller = self.dependencies.makeLoginViewController(coordinator: self)
        self.navigationController.pushViewController(controller, animated: true)
    }

    func startSignUp() {
        let controller = self.dependencies.makeSignUpViewController(coordinator: self)
        self.navigationController.pushViewController(controller, animated: true)
    }

    func onLoginCompleted() {
        self.onComplete?(true)
    }
}
