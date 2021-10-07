
extension DependencyContainer: ViewControllerFactory {
    func makeProfileViewController(coordinator: AppCoordinating) -> ProfileViewController {
        let fetcher = self.makeProfileFetcher()
        return ProfileViewController(fetcher: fetcher, coordinator: coordinator)
    }
}
