
extension DependencyContainer: ViewControllerFactory {
    func makeDiaryEntriesViewController(coordinator: DiaryEntriesCoordinating) -> DiaryEntriesViewController {
        let fetcher = self.makeDiaryEntriesFetcher()
        return DiaryEntriesViewController(fetcher: fetcher, coordinator: coordinator)
    }

    func makeEntryDetailsViewController(coordinator: DiaryEntriesCoordinating) -> EntryDetailsViewController {
        let fetcher = self.makeEntryDetailsFetcher()
        return EntryDetailsViewController(fetcher: fetcher, coordinator: coordinator)
    }

    func makeProfileViewController(coordinator: MainTabBarCoodinating) -> ProfileViewController {
        let fetcher = self.makeProfileFetcher()
        return ProfileViewController(fetcher: fetcher, coordinator: coordinator)
    }
}

// Authentication
extension DependencyContainer {
    
    func makeEntryViewController(coordinator: AuthenticationCoordinating) -> EntryViewController {
        return EntryViewController(coordinator: coordinator)
    }

    func makeLoginViewController(coordinator: AuthenticationCoordinating) -> LoginViewController {
        let fetcher = self.makeAuthenticationFetcher()
        return LoginViewController(fetcher: fetcher, coordinator: coordinator)
    }

    func makeRegisterViewController(coordinator: AuthenticationCoordinating) -> RegisterViewController {
        let fetcher = self.makeAuthenticationFetcher()
        return RegisterViewController(fetcher: fetcher, coordinator: coordinator)
    }
}
