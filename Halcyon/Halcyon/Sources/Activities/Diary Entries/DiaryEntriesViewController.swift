import UIKit
import Firebase

class DiaryEntriesViewController: ViewController<DiaryEntriesView> {
    let fetcher: DiaryEntriesFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

    var dataCount: Int = 10
    var canLoadMore: Bool = true

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

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryEntryTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? DiaryEntryTableViewCell else {
            return UITableViewCell()
        }
        cell.textView.delegate = self
        return cell
    }

    func onCellClick(at indexPath: IndexPath) {
        coordinator.showEntryDetails()
    }
}

extension DiaryEntriesViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        self.rootView.updateTableViewForHeightChange()
    }
}
