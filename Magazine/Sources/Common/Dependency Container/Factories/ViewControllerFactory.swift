import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: AppCoordinating) -> ProfileViewController
    func makeEntryViewController(coordinator: AppCoordinating) -> EntryViewController
}
