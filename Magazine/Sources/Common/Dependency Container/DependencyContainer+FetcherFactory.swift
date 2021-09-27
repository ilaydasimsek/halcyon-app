
extension DependencyContainer: FetcherFactory {

    func makeMainScreenFetcher() -> MainScreenFetching {
       return MainScreenFetcher(dependencies: self)
    }
}
