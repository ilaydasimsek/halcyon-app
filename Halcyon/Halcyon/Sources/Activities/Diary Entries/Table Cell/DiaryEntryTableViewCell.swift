import UIKit

class DiaryEntryTableViewCell: TableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView()
    }
}
