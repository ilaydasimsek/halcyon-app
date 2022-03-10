import UIKit
import Firebase

class ProfileViewController: ViewController<ProfileView> {

    let coordinator: MainTabBarCoodinating

    override var bottomTabBarStatus: VisibilityStatus {
        return .visible
    }
    
    init(coordinator: MainTabBarCoodinating) {
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }
}
