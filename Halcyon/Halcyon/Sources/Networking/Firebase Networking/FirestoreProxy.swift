import FirebaseFirestore
import SwiftyJSON
import OSLog

class FirestoreProxy {

    let auth: Authenticating

    init(auth: Authenticating) {
        self.auth = auth
    }

    func getDocument(for request: Requestable, completion: ((JSON?, Error?) -> Void)?) {
        guard let id = request.parameters["id"] else {
            Logger().error("Parameter id must be specified to get a document from firestore")
            return
        }
        FirestoreDatabase.shared
            .collection(request.path)
            .document(id)
            .getDocument { (documentSnapshot, error) in
                if let error = error {
                    completion?(nil, error)
                    return
                }

                guard let responseJson = self.formatSingleResponse(response: documentSnapshot) else {
                        completion?(nil, RequestError.unknownError)
                        return
                }
                
                completion?(responseJson, nil)
        }
    }

    func getDocuments(for request: Requestable, completion: ((JSON?, Error?) -> Void)?) {
        guard let userId = auth.userId else {
            auth.logout()
            Logger().error("User id is null in Firestore getDocuments, this might indicate an error in auth logic")
            return
        }

        FirestoreDatabase.shared
            .collection(request.path)
            .whereField("owner_id", isEqualTo: userId)
            .getDocuments() { (querySnapshot, error) in
            if let error = error {
                completion?(nil, error)
                return
            }

            guard let responseJson = self.formatArrayResponse(response: querySnapshot) else {
                    completion?(nil, RequestError.unknownError)
                    return
            }
            
            completion?(responseJson, nil)
        }
    }

    func saveDocument() {
        
    }

    func saveDocuments() {
        
    }

    private func formatArrayResponse(response: QuerySnapshot?) -> JSON? {
        guard let response = response?.documents else {
            return nil
        }
        let items: [JSON] = response.compactMap({ document in
            var additionalValues = ["id": document.documentID]

            // Format FIRTimestamp into a date value SwiftyJSON can understand
            if let timestamp = document.get("created_at") as? Timestamp,
               let formattedDateString = formatFirestoreTimestamp(timestamp) {
                additionalValues["created_at"] = formattedDateString
            }

            let mergedDict = document.data().merging(additionalValues)  { (current, new) in new }
            return JSON(mergedDict)
        })
        
        return JSON(["items": items])
    }

    private func formatFirestoreTimestamp(_ timestamp: Timestamp) -> String? {
        return JSON.jsonDateFormatter.string(from: timestamp.dateValue())
    }

    private func formatSingleResponse(response: DocumentSnapshot?) -> JSON? {
        guard let document = response else {
            return nil
        }
        
        
        return JSON(document)
    }
}
