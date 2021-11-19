import UIKit

class ProfileView: UIView {
    @IBOutlet weak var tableView: UITableView!

    @IBAction func onButtonClick(_ sender: Any) {
        FirebaseAuthenticator().logout()
    }
}
