import UIKit

// TODO add focus change on enter and keyboard close on tapping outside
class LoginView: UIView {
    @IBOutlet weak var emailTextField: AuthTextField!
    @IBOutlet weak var passwordTextField: AuthTextField!
    @IBOutlet weak var loginButton: BasicButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
    }

    private func prepareView() {
        emailTextField.titleText = "Email:"
        passwordTextField.titleText = "Password:"

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
