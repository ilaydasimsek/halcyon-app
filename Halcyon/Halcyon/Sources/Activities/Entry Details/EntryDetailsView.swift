import UIKit

class EntryDetailsView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }

    /**
        Used to update the table view cells when it's child's height changes.
        Needs to be called for table view cells with text views. Without this table views can't have a dynamic height.
     
        Refer to the following post for details:
        https://stackoverflow.com/questions/31595524/resize-uitableviewcell-containing-uitextview-upon-typing
     */
    func updateTableViewForHeightChange() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}
