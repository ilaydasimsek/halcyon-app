import Foundation
import SwiftyJSON
import FirebaseFirestore

struct DiaryEntry: Decodable {
    let id: String
    let title: String
    let creationDate: Date?

    static func decodeFromJson(_ json: JSON) throws -> DiaryEntry {
        let creationDate = json["creation_time"] as? Timestamp
        return DiaryEntry(
            id: json["id"].stringValue,
            title: json["title"].stringValue,
            creationDate: creationDate?.dateValue()
        )
    }
}

struct DiaryEntries: Decodable {

    let entries: [DiaryEntry]

    static func decodeFromJson(_ json: JSON) throws -> DiaryEntries {
        let entries: [DiaryEntry]? = try? json["items"].parseIntoArray()
        return DiaryEntries(
            entries: entries ?? []
        )
    }
}
