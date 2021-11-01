import Foundation

class EntryViewController: ViewController<EntryView> {
    let coordinator: AuthenticationCoordinating

    override var navigatioBarStatus: VisibilityStatus {
        return .hidden
    }
    
    init(coordinator: AuthenticationCoordinating) {
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
        prepareActions()
    }

    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    private func prepareActions() {
        rootView.loginButton.addTarget(controller: self,
                                       action: #selector(self.onClickLoginButton))
        rootView.registerButton.addTarget(controller: self,
                                        action: #selector(self.onClickRegisterButton))
    }

    @objc private func onClickLoginButton() {
        coordinator.startLogin()
    }

    @objc private func onClickRegisterButton() {
        coordinator.startRegister()
    }
}
