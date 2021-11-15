typealias CoordinatorDependencies = ViewControllerFactory
typealias FetcherDependencies = Networkable

protocol Networkable {
    var networking: Networking { get }
    var auth: Authenticating { get }
}

class DependencyContainer: Networkable {

    let networking: Networking = AlamofireNetwork()
    let auth: Authenticating = AuthService()
}
