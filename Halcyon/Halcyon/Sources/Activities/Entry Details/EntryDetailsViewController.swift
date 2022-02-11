import UIKit

class EntryDetailsViewController: ViewController<EntryDetailsView> {
    let fetcher: EntryDetailsFetching
    let coordinator: DiaryEntriesCoordinating
    var dataSource: TableViewDataProvider?

    var models = [
        "Test Test 11 Test Test 11 Test Test 11 Test Test 11 Test 11 Test Test 11 Test Test 11 Test Test 11",
        "Test Test 12",
        "Test Test 13",
        "Test Test 14",
        "Test Test 15",
        "Test Test 16",
        "Test Test 17",
        "Test Test 18",
        "Test Test 19",
        "Test Test 20"
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
        return self.models.count
    }

    var movable: Bool? {
        return true
    }

    func itemAt(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = EntryDetailItemTableViewCell.dequeue(forTableView: self.rootView.tableView, indexPath: indexPath) as? EntryDetailItemTableViewCell else {
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
