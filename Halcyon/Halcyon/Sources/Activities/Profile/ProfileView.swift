import UIKit

class ProfileView: UIView {
    @IBOutlet weak var screenNameLabel: UILabel!

    func setup(with profile: Profile) {
        self.screenNameLabel.text = profile.name
    }
}
