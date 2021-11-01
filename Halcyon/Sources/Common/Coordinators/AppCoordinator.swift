import UIKit
import SwiftyJSON

/// Main coordinator of application, will start the application depending on user state.
final class AppCoordinator: Coordinator {
    let loggedIn: Bool = false // TODO add real logged in logic

    lazy var authenticationCoordinator: AuthenticationCoordinating = {
        return AuthenticationCoordinator(navigationController: self.navigationController,
                                         dependencies: self.dependencies,
                                         onComplete: onSuccessfulAuthentication(_:))
    }()

    lazy var mainTabBarCoodinator: MainTabBarCoodinating = {
        return MainTabBarCoodinator(navigationController: self.navigationController,
                                    dependencies: self.dependencies)
    }()

    override func start() {
        if (loggedIn) {
            startApplication()
        } else {
            startAuthentication()
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

    func onSuccessfulAuthentication(_ success: Bool) {
        if (success) {
            self.startApplication()
        } else {
            // If somehow authentication process failed, go back to the start of authentication
            self.startAuthentication()
        }
    }
}

