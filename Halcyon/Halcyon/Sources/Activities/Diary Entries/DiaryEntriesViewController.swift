import UIKit
import Firebase

class DiaryEntriesViewController: ViewController<DiaryEntriesView> {
    let fetcher: DiaryEntriesFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProdiver?

    var dataCount: Int = 10
    var canLoadMore: Bool = true

    override var navigationBarTitle: String? {
        return "My Diary Entries"
    }

    init(fetcher: DiaryEntriesFetching, coordinator: DiaryEntriesCoordinating) {
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
        self.prepareUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }

    private func prepareUI() {
        prepareTable()
    }

    private func resetUI() {
        if let selectedIndexPath = rootView.tableView.indexPathForSelectedRow {
            rootView.tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
    
    private func prepareTable() {
        rootView.tableView.delegate = dataSource
        rootView.tableView.dataSource = dataSource
        rootView.tableView.prefetchDataSource = dataSource
        rootView.tableView.register(UINib(nibName: DiaryEntryTableViewCell.nibName, bundle: nil),
                                    forCellReuseIdentifier: DiaryEntryTableViewCell.nibName)
    }
}

extension DiaryEntriesViewController: TableViewProviderDelegate {
    
    var cellHeight: CGFloat? {
        return 100
    }
    
    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        return DiaryEntryTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath)
    }

    func loadMore() {
        dataCount += 10
        rootView.tableView.reloadData()
    }

    func onCellClick(at indexPath: IndexPath) {
        print("Clicked \(indexPath.row)")
        coordinator.showEntryDetails()
    }
}
