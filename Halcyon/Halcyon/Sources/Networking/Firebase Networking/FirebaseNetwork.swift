import Foundation
import PromiseKit
import FirebaseAuth
import SwiftyJSON
import FirebaseFirestore

class FirebaseNetwork: Networking {
    let dependencies: Authenticating
    
    let db = FirestoreDatabase.shared

    init(dependencies: Authenticating) {
        self.dependencies = dependencies
    }

    func decodedRequest<T>(_ request: Requestable) -> Promise<T> where T : Decodable {
        return Promise { promiseSeal in
            guard let userId = dependencies.userId else {
                _ = dependencies.logout()
                promiseSeal.reject(RequestError.unknownError)
                return
            }
            let collection = getCollection(for: request, userId: userId)

            switch (request.type) {
            case .firebase(let dataType):
                switch dataType {
                case .singleDocument:
                    // TODO: Add single document support
                    print("Not supported yet.")
                    promiseSeal.reject(RequestError.unknownError)
                    return
                case .multipleDocuments:
                    collection.getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            promiseSeal.reject(err)
                            return
                        }

                        guard let responseJson = self.formatArrayResponse(response: querySnapshot),
                            let response = try? T.decodeFromJson(responseJson) else {
                                promiseSeal.reject(RequestError.unknownError)
                                return
                        }
                        promiseSeal.fulfill(response)
                    }
                }
            default:
                fatalError("Firebase networking should be called with firebase typed request.")
            }
            
        }
    }

    private func getCollection(for request: Requestable, userId: String) -> Query {
        let collection = db.collection(request.path).whereField("owner_id", isEqualTo: userId)
        for (field,value) in request.parameters {
            collection.whereField(field, isEqualTo: value)
        }
        return collection
    }

    // TODO: Add creation time support
    private func formatArrayResponse(response: QuerySnapshot?) -> JSON? {
        guard let response = response?.documents else {
            return nil
        }
        let items: [JSON] = response.compactMap({ document in
            let mergedDict = document.data().merging(["id": document.documentID])  { (current, _) in current }
            return JSON(mergedDict)
        })
        
        return JSON(["items": items])
    }
}
