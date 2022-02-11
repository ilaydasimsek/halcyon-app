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
                                         onComplete: setNecessaryChildCoordinator)
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
        self.setNecessaryChildCoordinator()
    }

    private func setNecessaryChildCoordinator() {
        if (loggedIn) {
            self.startApplication()
        } else {
            self.startAuthentication()
        }
    }

    private func startApplication() {
        guard !self.hasChildCoordinator(mainTabBarCoodinator) else { return }
        addChildCoordinator(mainTabBarCoodinator)
        mainTabBarCoodinator.start()
    }

    private func startAuthentication() {
        guard !self.hasChildCoordinator(authenticationCoordinator) else { return }
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
        self.setNecessaryChildCoordinator()
    }
}
