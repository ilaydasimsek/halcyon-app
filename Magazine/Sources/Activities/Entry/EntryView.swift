import UIKit

class EntryView: UIView {
    @IBOutlet weak var loginButton: BasicButton!
    @IBOutlet weak var signupButton: BasicButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    private func setupUI() {
        loginButton.buttonTitle = "Login"
        signupButton.buttonTitle = "Sign Up"
    }
}
