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

                guard let responseJson = self.formatSingleResponse(snapshot: documentSnapshot) else {
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

            guard let responseJson = self.formatArrayResponse(snapshot: querySnapshot) else {
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

    private func formatArrayResponse(snapshot: QuerySnapshot?) -> JSON? {
        guard let documents = snapshot?.documents else {
            return nil
        }
        let items: [JSON] = documents.compactMap({ documentSnapshot in
            guard let formattedDocument = getFormattedDocument(forSnapshot: documentSnapshot) else {
                return nil
            }

            return JSON(formattedDocument)
        })
        
        return JSON(["items": items])
    }

    private func formatSingleResponse(snapshot: DocumentSnapshot?) -> JSON? {
        guard let snapshot = snapshot,
                let formattedDocument = getFormattedDocument(forSnapshot: snapshot) else {
            return nil
        }

        return JSON(formattedDocument)
    }

    private func getFormattedDocument(forSnapshot snapshot: DocumentSnapshot) -> [String : Any]? {
        var additionalValues = ["id": snapshot.documentID]
        if let timestamp = snapshot.get("created_at") as? Timestamp,
           let formattedDateString = formatFirestoreTimestamp(timestamp) {
            additionalValues["created_at"] = formattedDateString
        }
        return snapshot.data()?.merging(additionalValues)  { (current, new) in new }
    }

    private func formatFirestoreTimestamp(_ timestamp: Timestamp) -> String? {
        return JSON.jsonDateFormatter.string(from: timestamp.dateValue())
    }
}
