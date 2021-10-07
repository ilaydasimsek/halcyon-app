
extension DependencyContainer: FetcherFactory {

    func makeProfileFetcher() -> ProfileFetching {
       return ProfileFetcher(dependencies: self)
    }
}
