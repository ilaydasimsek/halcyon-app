import Foundation
import PromiseKit

class NetworkingProxy: Networking {
    let firebaseNetwork = FirebaseNetwork(auth: FirebaseAuthenticator())
    let alamofireNetwork = AlamofireNetwork()

    func decodedRequest<T>(_ request: Requestable) -> Promise<T> where T : Decodable {
        switch(request.type) {
            
        case .firebase:
            return firebaseNetwork.decodedRequest(request)
        case .http:
            return alamofireNetwork.decodedRequest(request)
        }
    }
}
