import UIKit

class ProfileView: UIView {
    @IBOutlet weak var screenNameLabel: UILabel!

    @IBAction func onButtonClick(_ sender: Any) {
        FirebaseAuthenticator().logout()
    }

    func setup(with profile: Profile) {
        self.screenNameLabel.text = profile.name
    }
}
