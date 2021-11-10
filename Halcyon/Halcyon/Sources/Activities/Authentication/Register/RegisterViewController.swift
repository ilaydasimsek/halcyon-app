import UIKit

// TODO remove password again
class RegisterViewController: ViewController<RegisterView> {
    let fetcher: AuthenticationFetching
    let coordinator: AuthenticationCoordinating

    init(fetcher: AuthenticationFetching, coordinator: AuthenticationCoordinating) {
        self.fetcher = fetcher
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareActions()
        prepareDelegates()
    }

    private func handleError(_ error: Error) {
        // TODO Handle firebase login register errors
        coordinator.onError(error)
    }

    private func validateFields() -> Bool {
        var errorTexts: [String] = []
        let email = rootView.emailTextField.value
        let password = rootView.passwordTextField.value

        if let error = AuthenticationValidator.validateEmail(email) {
            rootView.setError(to: rootView.emailTextField)
            errorTexts.append(error.errorText)
        }
    
        if let error = AuthenticationValidator.validatePassword(password) {
            rootView.setError(to: rootView.passwordTextField)
            errorTexts.append(error.errorText)
        }

        if errorTexts.count > 0 {
            rootView.setErrorText(errorTexts[0])
            return false
        }

        return true
    }
}

// MARK: - View preparation and button actions
extension RegisterViewController {

    private func prepareView() {
        rootView.emailTextField.setTag(0)
        rootView.passwordTextField.setTag(1)
    }

    private func prepareActions() {
        rootView.registerButton.addTarget(self,
                                          action: #selector(onClickRegisterButton),
                                          for: .touchUpInside)
    }

    private func prepareDelegates() {
        rootView.emailTextField.delegate = self
        rootView.passwordTextField.delegate = self
    }

    @objc func onClickRegisterButton() {
        guard validateFields() else { return }
        fetcher.register(email: rootView.emailTextField.value,
                       password: rootView.passwordTextField.value)
            .done({ [weak self] auth in
                self?.coordinator.onLoginCompleted(fromRegister: true)
            }).catch({ [weak self] error in
                self?.handleError(error)
            })
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rootView.clearErrors()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case rootView.emailTextField.tag:
            rootView.emailTextField.resignFirstResponder()
            rootView.passwordTextField.becomeFirstResponder()
        case rootView.passwordTextField.tag:
            rootView.passwordTextField.resignFirstResponder()
        default:
            rootView.emailTextField.resignFirstResponder()
            rootView.passwordTextField.resignFirstResponder()
        }
        return true
    }
}
