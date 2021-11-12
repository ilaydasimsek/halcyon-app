import Foundation
import PromiseKit

class Fetcher {
    let dependencies: FetcherDependencies
    
    var networking: Networking {
        return dependencies.networking
    }

    init(dependencies: FetcherDependencies) {
        self.dependencies = dependencies
    }
}
