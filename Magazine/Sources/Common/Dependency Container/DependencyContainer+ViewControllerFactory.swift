
extension DependencyContainer: ViewControllerFactory {
    func makeMainScreenViewController(coordinator: AppCoordinating) -> MainScreenViewController {
        let fetcher = self.makeMainScreenFetcher()
        return MainScreenViewController(fetcher: fetcher, coordinator: coordinator)
    }
}
