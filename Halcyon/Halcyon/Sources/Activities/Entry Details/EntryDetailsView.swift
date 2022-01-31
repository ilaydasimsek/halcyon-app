import UIKit

class EntryDetailsView: UIView {
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
    	// Use this function to do UI specific preparations
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

    func resetTableView() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
}
