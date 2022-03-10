
extension DependencyContainer: FetcherFactory {

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
