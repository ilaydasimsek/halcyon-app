
extension DependencyContainer: ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinator) -> ProfileViewController {
        let fetcher = self.makeProfileFetcher()
        return ProfileViewController(fetcher: fetcher, coordinator: coordinator)
    }

    func makeEntryViewController(coordinator: AuthenticationCoordinator) -> EntryViewController {
        return EntryViewController(coordinator: coordinator)
    }
}
