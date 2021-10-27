import UIKit

class SignUpView: UIView {
    @IBOutlet weak var emailTextField: AuthTextField!
    @IBOutlet weak var passwordTextField: AuthTextField!
    @IBOutlet weak var passwordAgainTextField: AuthTextField!
    @IBOutlet weak var signUpButton: BasicButton!

    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }

    private func prepareView() {
        emailTextField.titleText = "Email:"
        passwordTextField.titleText = "Password:"
        passwordAgainTextField.titleText = "Password (Again):"
    }
}
