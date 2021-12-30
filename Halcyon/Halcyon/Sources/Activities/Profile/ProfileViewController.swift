import UIKit
import Firebase

class ProfileViewController: ViewController<ProfileView> {

    let fetcher: ProfileFetching
    let coordinator: MainTabBarCoodinating

    override var bottomTabBarStatus: VisibilityStatus {
        return .visible
    }
    
    init(fetcher: ProfileFetching, coordinator: MainTabBarCoodinating) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchScreen()
    }

    private func fetchScreen() {
        // TODO add screen fetch logic
//        self.fetcher.getBaseScreen(screenId: "").done({ profile in
//            self.rootView.setup()
//        }).catch({ error in
//            print(error.localizedDescription)
//            // TODO Handle Error
//        })
    }
}
