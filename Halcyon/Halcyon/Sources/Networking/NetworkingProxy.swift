import Foundation
import PromiseKit

class NetworkingProxy: Networking {
    let firebaseNetwork = FirebaseNetwork(dependencies: FirebaseAuthenticator())
    let alamofireNetwork = AlamofireNetwork()

    func decodedRequest<T>(_ request: Requestable) -> Promise<T> where T : Decodable {
        switch(request.type) {
            
        case .firebase:
            return firebaseNetwork.decodedRequest(request)
        case .http:
            return alamofireNetwork.decodedRequest(request)
        case .authentication:
            // TODO: move authentication to here
            fatalError("Auth isn't implemented yet")
        }
    }
}
