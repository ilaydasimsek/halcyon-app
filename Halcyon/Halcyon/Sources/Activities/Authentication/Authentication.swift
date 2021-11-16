import Foundation
import FirebaseAuth

struct Authentication: Decodable {
    let userId: String
    let email: String
    let accessToken: String

    static func decode(_ data: Data) throws -> Authentication {
        let json = try data.asJson()
        return Authentication(
            userId: json["uid"].stringValue,
            email: json["email"].stringValue,
            accessToken: json["uid"].stringValue
        )
    }

    static func decodeFromFirebaseUser(_ user: User) -> Authentication {
        return Authentication(userId: user.uid, email: user.email ?? "", accessToken: user.uid)
    }
}
