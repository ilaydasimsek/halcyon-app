import Foundation
import FirebaseFirestore

class FirestoreDatabase {
    static let shared = Firestore.firestore()

    private init() {}
}
