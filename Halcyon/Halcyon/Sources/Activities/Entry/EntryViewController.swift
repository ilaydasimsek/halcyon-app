import Foundation

class EntryViewController: ViewController<EntryView> {
    let coordinator: AuthenticationCoordinating

    override var navigatioBarStatus: VisibilityStatus {
        return .hidden
    }
    
    init(coordinator: AuthenticationCoordinating) {
        self.coordinator = coordinator
        super.init(baseCoordinator: coordinator)
    }

    required init?(coder: NSCoder) {
        fatalError("Application doesn't use storyboard, init(coder:) shouldn't be called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareActions()
    }
    
    private func prepareActions() {
        rootView.loginButton.addTarget(self,
                                       action: #selector(self.onClickLoginButton),
                                       for: .touchUpInside)
        rootView.registerButton.addTarget(self,
                                          action: #selector(self.onClickRegisterButton),
                                          for: .touchUpInside)
    }

    @objc private func onClickLoginButton() {
        coordinator.startLogin()
    }

    @objc private func onClickRegisterButton() {
        coordinator.startRegister()
    }
}
