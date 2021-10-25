
extension DependencyContainer: FetcherFactory {

    func makeProfileFetcher() -> ProfileFetching {
       return ProfileFetcher(dependencies: self)
    }

    func makeAuthenticationFetcher() -> AuthenticationFetching {
        return AuthenticationFetcher(dependencies: self)
    }
}
