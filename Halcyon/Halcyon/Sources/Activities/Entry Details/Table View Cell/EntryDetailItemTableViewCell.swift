import UIKit

class EntryDetailItemTableViewCell: TableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView()
    }
}
