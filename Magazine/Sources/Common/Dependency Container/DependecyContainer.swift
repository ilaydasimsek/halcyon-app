typealias CoordinatorDependencies = ViewControllerFactory
typealias FetcherDependencies = Networkable

protocol Networkable {
    var networking: Networking { get }
}

class DependencyContainer: Networkable {
    let networking: Networking = AlamofireNetwork()
}
