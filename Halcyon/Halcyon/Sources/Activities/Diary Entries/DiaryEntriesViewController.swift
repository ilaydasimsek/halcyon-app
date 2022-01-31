import UIKit
import Firebase

class DiaryEntriesViewController: ViewController<DiaryEntriesView> {
    let fetcher: DiaryEntriesFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

    var dataCount: Int = 10
    var canLoadMore: Bool = true
    var models = [
        "Test Test 1",
        "Test Test 2",
        "Test Test 3",
        "Test Test 4",
        "Test Test 5",
        "Test Test 6",
        "Test Test 7",
        "Test Test 8",
        "Test Test 9",
        "Test Test 10"
    ]

    override var navigationBarTitle: String? {
        return "My Diary Entries"
    }

    init(fetcher: DiaryEntriesFetching, coordinator: DiaryEntriesCoordinating) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
        self.dataSource = TableViewDataProvider(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        // TODO listen to keyboard frame change for handling table scroll on keyboard open
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }

    private func prepareUI() {
        prepareTable()
    }

    private func resetUI() {
        rootView.resetTableView()
    }
    
    private func prepareTable() {
        rootView.tableView.registerNibCell(DiaryEntryTableViewCell.nibName)
        if let dataSource = dataSource {
            rootView.tableView.setupDataProvider(dataSource)
        }
    }
}

extension DiaryEntriesViewController: TableViewProviderDelegate {
    var movable: Bool? {
        return true
    }

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryEntryTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? DiaryEntryTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = models[indexPath.row]
        return cell
    }

    func moveRow(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath.row, " ", destinationIndexPath.row)
        models.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }

    func onCellClick(at indexPath: IndexPath) {
        self.coordinator.showEntryDetails()
    }
}
