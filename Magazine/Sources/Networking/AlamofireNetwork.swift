import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

protocol Networking {
    func request(_ request: Requestable) -> Promise<Data>
}

class AlamofireNetwork: Networking {
    private var sessionManager: Alamofire.Session!
    private let dispatchQueue = DispatchQueue(label: "alamofireNetworking", qos: .background, attributes: .concurrent)

    
    init() {
        reinitializeSessionManagers()
    }

    func reinitializeSessionManagers() {
        let foregroundConfiguration = URLSessionConfiguration.default
        self.sessionManager?.session.invalidateAndCancel()
        self.sessionManager = Alamofire.Session(configuration: foregroundConfiguration)
    }

    /**
        Used to send a request to backend.
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
    func request(_ request: Requestable) -> Promise<Data> {
        return Promise { promiseSeal in
            sessionManager.request(request.baseUrl.appendingPathComponent(request.path),
                method: request.method.alamofireEquivalent,
                parameters: request.parameters,
                encoding: request.method.encoding)
                    .responseData(queue: self.dispatchQueue) { response in
                        switch response.result {
                        case .success(let value):
                           promiseSeal.fulfill(value)
                        case .failure(let error):
                           promiseSeal.reject(error)
                        }
                    }
            }

    }
}
