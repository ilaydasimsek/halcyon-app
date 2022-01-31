import UIKit

protocol MainTabBarCoodinating where Self: Coordinatable {
    func getTabBarController(for item: MainTabBarItem) -> UIViewController
}

class MainTabBarCoodinator: Coordinator, MainTabBarCoodinating {
    let diaryEntriesCoordinator: DiaryEntriesCoordinator

    override init(navigationController: UINavigationController, dependencies: CoordinatorDependencies) {
        diaryEntriesCoordinator = DiaryEntriesCoordinator(navigationController: navigationController,
                                                          dependencies: dependencies)
        super.init(navigationController: navigationController,
                   dependencies: dependencies)
    }

    override func start() {
        let mainTabBarController = MainTabBarController(coordinator: self)
        self.setViewController(as: mainTabBarController, animated: true)
    }

    func getTabBarController(for item: MainTabBarItem) -> UIViewController {
        switch item.type {
        case .profile:
            return dependencies.makeProfileViewController(coordinator: self)
        case .diaryEntries:
            return dependencies.makeEntryDetailsViewController(coordinator: diaryEntriesCoordinator)
        default:
            return UIViewController()
        }
    }

}

