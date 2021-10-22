import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinator) -> ProfileViewController
    func makeEntryViewController(coordinator: AuthenticationCoordinator) -> EntryViewController
}
