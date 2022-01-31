import UIKit

class EntryDetailsViewController: ViewController<EntryDetailsView> {
    let fetcher: EntryDetailsFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

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
        return "Entry Item"
    }

    init(fetcher: EntryDetailsFetching, coordinator: DiaryEntriesCoordinating) {
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
        rootView.tableView.dragDelegate = self
        rootView.tableView.dropDelegate = self
        rootView.tableView.dragInteractionEnabled = true
    }

    private func fetch() {

        /**
            Send the fetch request here, ideally this should return a promise using PromiseKit
            To listen to the returned promise:
                Promise<Data>.done({ data in
                   // Handle success
                }).catch({ error in
                   // Handle error
                })
        */
    }
}

extension EntryDetailsViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        // Implementation not necessary
        // Drop delegate is only used to show the correct preview while dropping
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = models[indexPath.row]
        return [ dragItem ]
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return getDraggablePropertiesCell(tableView, for: indexPath)
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return getDraggablePropertiesCell(tableView, for: indexPath)
    }

    func getDraggablePropertiesCell(_ tableView: UITableView, for indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = tableView.cellForRow(at: indexPath) as? DiaryEntryTableViewCell else {
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
        return self.models.count
    }

    var movable: Bool? {
        return true
    }

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryEntryTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? DiaryEntryTableViewCell else {
            return UITableViewCell()
        }
        cell.textView.delegate = self
        cell.textView.text = models[indexPath.row]
        return cell
    }

    func moveRow(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath.row, " ", destinationIndexPath.row)
        models.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension EntryDetailsViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        self.rootView.updateTableViewForHeightChange()
    }
}
