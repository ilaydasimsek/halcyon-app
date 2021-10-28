import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinator) -> ProfileViewController

    // Authentication
    func makeEntryViewController(coordinator: AuthenticationCoordinator) -> EntryViewController
    func makeRegisterViewController(coordinator: AuthenticationCoordinator) -> RegisterViewController
    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController
}
