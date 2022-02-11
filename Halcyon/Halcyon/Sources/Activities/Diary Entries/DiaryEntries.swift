import Foundation

struct DiaryEntry: Decodable {
    let id: String
    let title: String
    let creationDate: Date?

    static func decode(_ data: Data) throws -> DiaryEntry {
        let json = try data.asJson()
        return DiaryEntry(
            id: json["id"].stringValue,
            title: json["title"].stringValue,
            creationDate: json["creationDate"].date
        )
    }
}
