import Foundation

struct Profile: Decodable {
    let name: String

    static func decode(_ data: Data) throws -> Profile {
        let json = try data.asJson()
        return Profile(
            name: json["name"].stringValue
        )
    }
}
