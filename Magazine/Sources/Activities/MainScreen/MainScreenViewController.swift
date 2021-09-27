import UIKit

class MainScreenViewController: ViewController<MainScreenView> {
    let fetcher: MainScreenFetching

    override var bottomTabBarStatus: VisibilityStatus {
        return .visible
    }

    init(fetcher: MainScreenFetching, coordinator: AppCoordinating) {
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
        self.rootView.setup(with: MainScreen(name: "Main Screen"))
//        self.fetcher.getBaseScreen(screenId: "").done({ mainScreen in
//            self.rootView.setup(with: mainScreen)
//        }).catch({ error in
//            print(error.localizedDescription)
//            // TODO Handle Error
//        })
    }
}
