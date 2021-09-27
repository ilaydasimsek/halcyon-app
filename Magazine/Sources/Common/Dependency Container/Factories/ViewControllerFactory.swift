import Foundation

protocol ViewControllerFactory {
    func makeMainScreenViewController(coordinator: AppCoordinating) -> MainScreenViewController
}
