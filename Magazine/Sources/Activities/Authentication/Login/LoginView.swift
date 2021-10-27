import UIKit

// TODO add focus change on enter and keyboard close on tapping outside
class LoginView: UIView {
    @IBOutlet weak var usernameTextField: AuthTextField!
    @IBOutlet weak var passwordTextField: AuthTextField!
    @IBOutlet weak var loginButton: BasicButton!

    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }

    private func prepareView() {
        usernameTextField.titleText = "Username:"
        passwordTextField.titleText = "Password:"
    }
}
