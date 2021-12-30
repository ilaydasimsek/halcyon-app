import Foundation

protocol ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinating) -> ProfileViewController
    func makeDiaryEntriesViewController(coordinator: DiaryEntriesCoordinating) -> DiaryEntriesViewController
    func makeEntryDetailsViewController(coordinator: DiaryEntriesCoordinating) -> EntryDetailsViewController

    // Authentication
    func makeEntryViewController(coordinator: AuthenticationCoordinating) -> EntryViewController
    func makeRegisterViewController(coordinator: AuthenticationCoordinating) -> RegisterViewController
    func makeLoginViewController(coordinator: AuthenticationCoordinating) -> LoginViewController
}
