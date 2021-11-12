import UIKit

protocol AuthenticationCoordinating where Self: Coordinatable {
    func startLogin()
    func startRegister()
    func onLoginCompleted(fromRegister: Bool)
    func onError(_ error: Error)
}

class AuthenticationCoordinator: Coordinator, AuthenticationCoordinating {
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

    func startRegister() {
        let controller = self.dependencies.makeRegisterViewController(coordinator: self)
        self.navigationController.pushViewController(controller, animated: true)
    }

    func onLoginCompleted(fromRegister: Bool = false) {
        if (fromRegister) {
            AnalyticsEventLogger.register()
        } else {
            AnalyticsEventLogger.login()
        }
        self.onComplete?(true)
    }

    // TODO handle error with custom dialogs properly
    func onError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.navigationController.present(alert, animated: true, completion: nil)
    }
}
