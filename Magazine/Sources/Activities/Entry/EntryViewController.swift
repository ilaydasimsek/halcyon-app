import Foundation

class EntryViewController: ViewController<EntryView, AuthenticationCoordinator> {

    override var navigatioBarStatus: VisibilityStatus {
        return .hidden
    }
    
    override init(coordinator: AuthenticationCoordinator) {
        super.init(coordinator: coordinator)
        prepareActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    private func prepareActions() {
        rootView.loginButton.addTarget(controller: self,
                                       action: #selector(self.onClickLoginButton))
        rootView.signupButton.addTarget(controller: self,
                                        action: #selector(self.onClickSignUpButton))
    }

    @objc private func onClickLoginButton() {
        coordinator.startLogin()
    }

    @objc private func onClickSignUpButton() {
        coordinator.startSignUp()
    }
}
