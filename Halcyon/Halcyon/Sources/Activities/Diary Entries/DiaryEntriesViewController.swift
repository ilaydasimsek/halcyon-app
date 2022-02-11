import UIKit
import Firebase

class DiaryEntriesViewController: ViewController<DiaryEntriesView> {
    let fetcher: DiaryEntriesFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

    var canLoadMore: Bool = true
    var entries: [DiaryEntry] = [] {
        didSet {
            rootView.tableView.reloadData()
        }
    }

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
        self.fetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }

    private func prepareUI() {
        prepareTable()
    }

    private func fetch() {
        self.fetcher.fetchDiaryEntries().done({ [weak self] entries in
            self?.entries = entries
        }).catch({ [weak self] error in
            print(error)
        })
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
    var dataCount: Int {
        return entries.count
    }

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryEntryTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? DiaryEntryTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = entries[indexPath.row].title
        return cell
    }

    func onCellClick(at indexPath: IndexPath) {
        self.coordinator.showEntryDetails()
    }
}
