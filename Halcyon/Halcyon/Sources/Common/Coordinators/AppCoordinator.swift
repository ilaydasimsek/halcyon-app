import UIKit
import SwiftyJSON
import FirebaseAuth

/// Main coordinator of application, will start the application depending on user state.
final class AppCoordinator: Coordinator {
    var loggedIn: Bool {
        return self.dependencies.auth.authenticated
    }

    lazy var authenticationCoordinator: AuthenticationCoordinating = {
        return AuthenticationCoordinator(navigationController: self.navigationController,
                                         dependencies: self.dependencies,
                                         onComplete: onAuthStateChanged)
    }()

    lazy var mainTabBarCoodinator: MainTabBarCoodinating = {
        return MainTabBarCoodinator(navigationController: self.navigationController,
                                    dependencies: self.dependencies)
    }()

    override init(navigationController: UINavigationController, dependencies: CoordinatorDependencies) {
        super.init(navigationController: navigationController, dependencies: dependencies)
        self.setupNotifications()
    }

    override func start() {
        self.onAuthStateChanged()
    }

    func onAuthStateChanged() {
        if (loggedIn) {
            self.startApplication()
        } else {
            self.startAuthentication()
        }
    }

    func startApplication() {
        addChildCoordinator(mainTabBarCoodinator)
        mainTabBarCoodinator.start()
    }

    func startAuthentication() {
        addChildCoordinator(authenticationCoordinator)
        authenticationCoordinator.start()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Coordinator Setup
extension AppCoordinator {

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onAuthStateNotification(_:)),
                                               name: NotificationConstants.authStateChanged,
                                               object: nil)
    }

    @objc func onAuthStateNotification(_ sender: Notification) {
        self.onAuthStateChanged()
    }
}
