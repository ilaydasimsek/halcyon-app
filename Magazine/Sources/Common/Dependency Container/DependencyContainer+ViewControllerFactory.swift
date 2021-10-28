
extension DependencyContainer: ViewControllerFactory {
    func makeProfileViewController(coordinator: MainTabBarCoodinator) -> ProfileViewController {
        let fetcher = self.makeProfileFetcher()
        return ProfileViewController(fetcher: fetcher, coordinator: coordinator)
    }
}

// Authentication
extension DependencyContainer {
    
    func makeEntryViewController(coordinator: AuthenticationCoordinator) -> EntryViewController {
        return EntryViewController(coordinator: coordinator)
    }

    func makeLoginViewController(coordinator: AuthenticationCoordinator) -> LoginViewController {
        let fetcher = self.makeAuthenticationFetcher()
        return LoginViewController(fetcher: fetcher, coordinator: coordinator)
    }

    func makeRegisterViewController(coordinator: AuthenticationCoordinator) -> RegisterViewController {
        let fetcher = self.makeAuthenticationFetcher()
        return RegisterViewController(fetcher: fetcher, coordinator: coordinator)
    }
}
