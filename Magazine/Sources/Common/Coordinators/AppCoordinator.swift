import UIKit
import SwiftyJSON

protocol AppCoordinating {
    func getTabBarController(for item: MainTabBarItem) -> UIViewController
}

/// Main coordinator of application, will start the application depending on user state.
final class AppCoordinator: Coordinator, AppCoordinating {

    override func start() {
        let mainTabBarController = MainTabBarController(coordinator: self)
        self.setViewController(as: mainTabBarController)
    }

    func getTabBarController(for item: MainTabBarItem) -> UIViewController {
        return dependencies.makeMainScreenViewController(coordinator: self)
    }
}
