import UIKit

class RegisterViewController: ViewController<RegisterView, AuthenticationCoordinator> {
    let fetcher: AuthenticationFetching

    init(fetcher: AuthenticationFetching, coordinator: AuthenticationCoordinator) {
        self.fetcher = fetcher
        super.init(coordinator: coordinator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareActions()
    }

    private func prepareActions() {
        rootView.registerButton.addTarget(controller: self, action: #selector(onClickRegisterButton))
    }

    @objc func onClickRegisterButton() {
        fetcher.register(email: rootView.emailTextField.value,
                       password: rootView.passwordTextField.value,
                       passwordAgain: rootView.passwordAgainTextField.value)
            .done({ [weak self] auth in
                self?.coordinator.onLoginCompleted()
            }).catch({ [weak self] error in
                self?.coordinator.onError(error)
            })
    }
}
