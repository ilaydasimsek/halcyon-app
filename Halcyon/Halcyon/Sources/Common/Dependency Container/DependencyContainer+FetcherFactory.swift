
extension DependencyContainer: FetcherFactory {

    func makeProfileFetcher() -> ProfileFetching {
       return ProfileFetcher(dependencies: self)
    }

    func makeDiaryEntriesFetcher() -> DiaryEntriesFetching {
       return DiaryEntriesFetcher(dependencies: self)
    }

    func makeEntryDetailsFetcher() -> EntryDetailsFetching {
        return EntryDetailsFetcher(dependencies: self)
    }

    func makeAuthenticationFetcher() -> AuthenticationFetching {
        return AuthenticationFetcher(dependencies: self)
    }
}
