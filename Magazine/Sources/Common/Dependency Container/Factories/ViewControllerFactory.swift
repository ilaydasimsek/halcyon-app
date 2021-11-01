import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinating) -> ProfileViewController

    // Authentication
    func makeEntryViewController(coordinator: AuthenticationCoordinating) -> EntryViewController
    func makeRegisterViewController(coordinator: AuthenticationCoordinating) -> RegisterViewController
    func makeLoginViewController(coordinator: AuthenticationCoordinating) -> LoginViewController
}
