
protocol FetcherFactory {
    func makeProfileFetcher() -> ProfileFetching
    func makeAuthenticationFetcher() -> AuthenticationFetching
}
