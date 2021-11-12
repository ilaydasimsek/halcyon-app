import UIKit

class ProfileView: UIView {
    @IBOutlet weak var screenNameLabel: UILabel!

    @IBAction func onButtonClick(_ sender: Any) {
        NotificationCenter.default.post(name: NotificationConstants.userUnauthorized, object: nil, userInfo: [:])
    }

    func setup(with profile: Profile) {
        self.screenNameLabel.text = profile.name
    }
}
