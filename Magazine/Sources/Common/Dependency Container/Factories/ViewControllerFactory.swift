import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinator) -> ProfileViewController

    // Authentication
    func makeEntryViewController(coordinator: AuthenticationCoordinator) -> EntryViewController
    func makeSignUpViewController(coordinator: AuthenticationCoordinator) -> SignUpViewController
    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController
}
