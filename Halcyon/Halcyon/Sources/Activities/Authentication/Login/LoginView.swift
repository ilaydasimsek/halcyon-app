import UIKit

class LoginView: UIView {
    @IBOutlet weak var emailTextField: AuthTextField!
    @IBOutlet weak var passwordTextField: AuthTextField!
    @IBOutlet weak var loginButton: BasicButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        emailTextField.titleText = "Email:"
        passwordTextField.titleText = "Password:"

        errorLabel.font = UIFont.regular14
        clearErrors()
    }

    func setError(to field: AuthTextField) {
        field.setState(.error)
    }

    func setErrorText(_ text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }

    func clearErrors() {
        errorLabel.text = ""
        errorLabel.isHidden = true

        emailTextField.setState(.normal)
        passwordTextField.setState(.normal)
    }
}
