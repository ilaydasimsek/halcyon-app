import UIKit

class ProfileViewController: ViewController<ProfileView>, TableViewProviderDelegate {

    let fetcher: ProfileFetching
    let coordinator: MainTabBarCoodinating
    var dataSource: TableViewDataProdiver?

    override var bottomTabBarStatus: VisibilityStatus {
        return .visible
    }
    
    var dataCount: Int = 10
    var canLoadMore: Bool = true
    
    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        return HalcyonTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath)
    }
    

    func loadMore() {
        dataCount += 10
        rootView.tableView.reloadData()
        print("Load more called")
    }
    
    init(fetcher: ProfileFetching, coordinator: MainTabBarCoodinating) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
        
        self.dataSource = TableViewDataProdiver(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareTable()
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

    private func prepareTable() {
        rootView.tableView.delegate = dataSource
        rootView.tableView.dataSource = dataSource
        rootView.tableView.prefetchDataSource = dataSource
        rootView.tableView.register(UINib(nibName: HalcyonTableViewCell.nibName, bundle: nil),
                                    forCellReuseIdentifier: HalcyonTableViewCell.nibName)
    }
}
