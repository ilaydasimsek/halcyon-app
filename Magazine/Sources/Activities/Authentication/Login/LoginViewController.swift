import UIKit

class LoginViewController: ViewController<LoginView, AuthenticationCoordinator> {
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
        rootView.loginButton.addTarget(controller: self, action: #selector(onClickLoginButton))
    }

    @objc func onClickLoginButton() {
        coordinator.onLoginCompleted()
    }
}
