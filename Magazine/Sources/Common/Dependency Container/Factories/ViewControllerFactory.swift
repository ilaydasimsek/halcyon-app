import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: AppCoordinating) -> ProfileViewController
}
