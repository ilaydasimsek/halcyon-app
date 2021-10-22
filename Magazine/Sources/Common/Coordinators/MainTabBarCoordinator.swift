import UIKit

class MainTabBarCoodinator: Coordinator {

    override func start() {
        let mainTabBarController = MainTabBarController(coordinator: self)
        self.setViewController(as: mainTabBarController)
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

