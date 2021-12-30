import UIKit

class ProfileView: UIView {

    @IBAction func onButtonClick(_ sender: Any) {
        FirebaseAuthenticator().logout()
    }
}
