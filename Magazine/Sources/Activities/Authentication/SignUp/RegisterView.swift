import UIKit

class RegisterView: UIView {
    @IBOutlet weak var emailTextField: AuthTextField!
    @IBOutlet weak var passwordTextField: AuthTextField!
    @IBOutlet weak var passwordAgainTextField: AuthTextField!
    @IBOutlet weak var registerButton: BasicButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }

    private func prepareView() {
        emailTextField.titleText = "Email:"
        passwordTextField.titleText = "Password:"
        passwordAgainTextField.titleText = "Password (Again):"

        errorLabel.font = UIFont.regular14
        clearError()
    }

    func setError(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }

    func clearError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
}
