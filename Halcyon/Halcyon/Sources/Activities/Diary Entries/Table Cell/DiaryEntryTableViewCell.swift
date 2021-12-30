import UIKit

class DiaryEntryTableViewCell: TableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = "Entry 1"
    }
}
