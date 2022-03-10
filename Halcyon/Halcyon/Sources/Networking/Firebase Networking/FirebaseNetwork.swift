import Foundation
import PromiseKit
import SwiftyJSON
import OSLog

class FirebaseNetwork: Networking {
    let auth: Authenticating
    let firestore: FirestoreProxy
    
    let db = FirestoreDatabase.shared

    init(auth: Authenticating) {
        self.auth = auth
        self.firestore = FirestoreProxy(auth: auth)
    }

    func decodedRequest<T>(_ request: Requestable) -> Promise<T> where T : Decodable {
        return Promise { promiseSeal in
            guard case let .firebase(dataType) = request.type else {
                Logger().error("Firestore only supports firebase requests")
                return
            }
            let requestCompletion: (JSON?, Error?) -> Void = { (responseJson, error) in
                if let responseJson = responseJson, let response = try? T.decodeFromJson(responseJson) {
                    promiseSeal.fulfill(response)
                } else {
                    promiseSeal.reject(error ?? RequestError.unknownError)
                }
            }

            switch request.method {
            case .get:
                switch dataType {
                case .singleDocument:
                    firestore.getDocument(for: request, completion: requestCompletion)
                case .multipleDocuments:
                    firestore.getDocuments(for: request, completion: requestCompletion)
                }
            case .post:
                fatalError("Post isn't implemented yet")
            default:
                fatalError("This request method isn't supported by FirestoreProxy")
            }
        }
    }
}
