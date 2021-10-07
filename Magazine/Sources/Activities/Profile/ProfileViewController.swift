import UIKit

class ProfileViewController: ViewController<ProfileView> {
    let fetcher: ProfileFetching

    override var bottomTabBarStatus: VisibilityStatus {
        return .visible
    }

    init(fetcher: ProfileFetching, coordinator: AppCoordinating) {
        self.fetcher = fetcher
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
