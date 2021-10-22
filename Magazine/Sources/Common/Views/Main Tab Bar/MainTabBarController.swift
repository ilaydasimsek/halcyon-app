import UIKit
import SwiftyJSON
import Nuke

class MainTabBarController: UITabBarController {

    private let selectedItemTintColor = Colors.primary
    private let unselectedItemTintColor = Colors.paleGray
    private let backgroundColor = Colors.ivory
    
    private let coordinator: MainTabBarCoodinator
    private var tabBarViewControllers: [UIViewController]?


    init(coordinator: MainTabBarCoodinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBar()
    }

    func prepareTabBar() {
        makeVersionSpecificPreparations()
        prepareControllers()
    }

    private func prepareControllers() {
        // TODO add backend
        guard let tabBarItems: [MainTabBarItem] = try? JsonListDecoder().decode(configJson["bottom_navigation"]) else { return }
        self.viewControllers = tabBarItems.enumerated().compactMap { (index, element) in
            self.getTabBarController(for: element, tag: index)
        }
    }
}

// MARK: - View setup
private extension MainTabBarController {
    /**
        
        The setup function that does necessary preparation depending on platform version.
     
         Tab bar preparation has changed after iOS 13, so we need to do different setup for different versions.
     */
    func makeVersionSpecificPreparations() {
        if #available(iOS 13.0, *) {
            let appearance = tabBar.standardAppearance
            appearance.backgroundColor = backgroundColor
            appearance.backgroundEffect = .none
            appearance.stackedLayoutAppearance.selected.iconColor = selectedItemTintColor
            appearance.stackedLayoutAppearance.normal.iconColor = unselectedItemTintColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor:selectedItemTintColor]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: unselectedItemTintColor]
            tabBar.standardAppearance = appearance
        } else {
            tabBar.backgroundColor = backgroundColor
            tabBar.barTintColor = backgroundColor
            tabBar.tintColor = selectedItemTintColor
            tabBar.unselectedItemTintColor = unselectedItemTintColor
        }
    }

    func getTabBarController(for item: MainTabBarItem, tag: Int) -> UIViewController? {
        guard let _ = item.type else { return nil }
        let controller: UIViewController = coordinator.getTabBarController(for: item)

        let tabBarItem = UITabBarItem(title: item.title, image: nil, tag: tag)
        controller.tabBarItem = tabBarItem

        self.setupIcon(forItem: tabBarItem, url: item.iconUrl)
        return controller
    }
    
    func setupIcon(forItem tabBarItem: UITabBarItem, url: URL?) {
        guard let url = url else { return }
        ImagePipeline.shared.loadImage(with: url) { response in // 4
         switch response {
         case let .success(imageResponse):
            tabBarItem.image = imageResponse.image
         default:
            return
         }
       }
    }
}

private extension MainTabBarController {
    private var configJson: JSON { return JSON([
        "bottom_navigation": [
                    ["type": "profile", "label": "Profile", "icon": "",],
                    ["type": "home", "label": "Latest", "icon": "",]]
                ,]
        )
    }
}
