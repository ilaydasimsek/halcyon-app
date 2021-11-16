import Foundation
import PromiseKit

class Fetcher {
    let dependencies: FetcherDependencies
    
    var networking: Networking {
        return dependencies.networking
    }
    
    var auth: Authenticating {
        return dependencies.auth
    }

    init(dependencies: FetcherDependencies) {
        self.dependencies = dependencies
    }
}
