
protocol FetcherFactory {
    func makeAuthenticationFetcher() -> AuthenticationFetching
    func makeEntryDetailsFetcher() -> EntryDetailsFetching
    func makeDiaryEntriesFetcher() -> DiaryEntriesFetching
}
