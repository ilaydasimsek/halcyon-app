
protocol FetcherFactory {
    func makeProfileFetcher() -> ProfileFetching
    func makeAuthenticationFetcher() -> AuthenticationFetching
    func makeEntryDetailsFetcher() -> EntryDetailsFetching
    func makeDiaryEntriesFetcher() -> DiaryEntriesFetching
}
