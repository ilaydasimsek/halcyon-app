typealias CoordinatorDependencies = ViewControllerFactory & Networkable
typealias FetcherDependencies = Networkable

protocol Networkable {
    var networking: Networking { get }
    var auth: Authenticating { get }
}

class DependencyContainer: Networkable {

    let networking: Networking = NetworkingProxy()
    let auth: Authenticating = FirebaseAuthenticator()
}
