import UIKit
import SwiftyJSON

protocol AppCoordinating {
    func getTabBarController(for item: MainTabBarItem) -> UIViewController
}

/// Main coordinator of application, will start the application depending on user state.
final class AppCoordinator: Coordinator, AppCoordinating {
    let loggedIn: Bool = false // TODO add real logged in logic

    override func start() {
        if (loggedIn) {
            let mainTabBarController = MainTabBarController(coordinator: self)
            self.setViewController(as: mainTabBarController)
        } else {
            self.setViewController(as: dependencies.makeEntryViewController(coordinator: self))
        }
    }

    func getTabBarController(for item: MainTabBarItem) -> UIViewController {
        switch item.type {
        case .profile:
            return dependencies.makeProfileViewController(coordinator: self)
        default:
            return UIViewController()
        }
    }
}
