import UIKit

class EntryDetailsViewController: ViewController<EntryDetailsView> {
    let fetcher: EntryDetailsFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

    let entryId: String

    var entry: DiaryEntryDetails? {
        didSet {
            rootView.tableView.reloadData()
        }
    }

    override var navigationBarTitle: String? {
        return "Entry Item"
    }

    init(fetcher: EntryDetailsFetching, coordinator: DiaryEntriesCoordinating, entryId: String) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        self.entryId = entryId
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
        // TODO listen to keyboard frame change for handling table scroll on keyboard open
    }

    private func prepareUI() {
        prepareTable()
    }
    
    private func prepareTable() {
        rootView.tableView.registerNibCell(EntryDetailItemTableViewCell.nibName)
        if let dataSource = dataSource {
            rootView.tableView.setupDataProvider(dataSource)
        }
        rootView.tableView.dragDelegate = self
        rootView.tableView.dropDelegate = self
        rootView.tableView.dragInteractionEnabled = true
    }

    private func fetch() {
        self.fetcher.fetchEntry(id: self.entryId).done({ [weak self] entry in
            self?.entry = entry
        }).catch({ error in
            print(error)
        })
    }
}

extension EntryDetailsViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        // Implementation not necessary
        // Drop delegate is only used to show the correct preview while dropping
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        if let localObject = entry?.items[safe: indexPath.row]?.content {
            dragItem.localObject = localObject
        }
        return [ dragItem ]
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return getDraggablePropertiesCell(tableView, for: indexPath)
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return getDraggablePropertiesCell(tableView, for: indexPath)
    }

    func getDraggablePropertiesCell(_ tableView: UITableView, for indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = tableView.cellForRow(at: indexPath) as? EntryDetailItemTableViewCell else {
            return UIDragPreviewParameters()
        }
        let previewParameters = UIDragPreviewParameters()
        let path = UIBezierPath(roundedRect: cell.containerView.frame, cornerRadius: 12.0)
        previewParameters.visiblePath = path
        previewParameters.backgroundColor = .clear
        return previewParameters
    }
}

extension EntryDetailsViewController: TableViewProviderDelegate {
    var dataCount: Int {
        return self.entry?.items.count ?? 0
    }

    var movable: Bool? {
        return true
    }

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = EntryDetailItemTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? EntryDetailItemTableViewCell else {
            return UITableViewCell()
        }
        cell.textView.delegate = self
        cell.textView.text = entry?.items[indexPath.row].content
        return cell
    }

    func moveRow(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath.row, " ", destinationIndexPath.row)
        entry?.items.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension EntryDetailsViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        self.rootView.updateTableViewForHeightChange()
    }
}
