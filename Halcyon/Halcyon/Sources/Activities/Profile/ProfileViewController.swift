import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchScreen()
    }

    private func fetchScreen() {
        // TODO add screen fetch logic
        self.rootView.setup(with: Profile(name: "User Profile Screen"))
//        self.fetcher.getBaseScreen(screenId: "").done({ profile in
//            self.rootView.setup(with: profile)
//        }).catch({ error in
//            print(error.localizedDescription)
//            // TODO Handle Error
//        })
    }
}
