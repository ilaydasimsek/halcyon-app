import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

protocol Networking {
    func decodedRequest<T: Decodable>(_ request: Requestable) -> Promise<T>
}

class AlamofireNetwork: Networking {
    private var sessionManager: Alamofire.Session
    private let dispatchQueue = DispatchQueue(label: "alamofireNetworking", qos: .background, attributes: .concurrent)

    
    init(sessionManager: Alamofire.Session? = nil) {
        if let sessionManager = sessionManager {
            self.sessionManager = sessionManager
        } else {
            let foregroundConfiguration = URLSessionConfiguration.default
            self.sessionManager = Alamofire.Session(configuration: foregroundConfiguration)
        }
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
    func request(_ request: Requestable) -> Promise<JSON> {
        return Promise { promiseSeal in
            sessionManager.request(request.baseUrl.appendingPathComponent(request.path),
                method: request.method.alamofireEquivalent,
                parameters: request.parameters,
                encoding: request.method.encoding)
                    .responseData(queue: self.dispatchQueue) { response in
                        switch response.result {
                        case .success(let value):
                            guard let json = try? value.asJson() else {
                                promiseSeal.reject(RequestError.decodeError)
                                return
                            }
                           promiseSeal.fulfill(json)
                        case .failure(let error):
                            promiseSeal.reject(RequestError.from(error))
                        }
                    }
            }

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
    func decodedRequest<T: Decodable>(_ request: Requestable) -> Promise<T> {
        return Promise { promiseSeal in
            self.request(request).done({ json in
                guard let response = try? T.decodeFromJson(json) else {
                    promiseSeal.reject(RequestError.decodeError)
                    return
                }
                promiseSeal.fulfill(response)
            }).catch({error in
                promiseSeal.reject(RequestError.from(error))
            })
        }
    }
}

