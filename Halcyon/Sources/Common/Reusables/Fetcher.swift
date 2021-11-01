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

    /**
        Used to send a request to backend. Decodes the backend response into the given type of model.
     - parameters:
        - request: A Requestable object that has the request details
     - returns:
        A Promise<Data> that can be used to handle response or error
            
         To listen to the returned promise:
            Promise<Data>.done({ data in
               // Handle success
            }).catch({ error in
               // Handle error
            })
     */
    func request<T: Decodable>(_ request: Requestable) -> Promise<T> {
        return Promise { promiseSeal in
            self.networking.request(request).done({ data in
                guard let response = try? T.decode(data) else {
                    promiseSeal.reject(RequestError.decodeError)
                    return
                }
                promiseSeal.fulfill(response)
            }).catch({error in
                promiseSeal.reject(error)
            })
        }
    }
}
