import Foundation
import SwiftyJSON

struct DiaryEntryItem: Decodable {
    let id: String
    let title: String
    let content: String
    let type: String

    static func decodeFromJson(_ json: JSON) throws -> DiaryEntryItem {
        return DiaryEntryItem(
            id: json["type"].stringValue,
            title: json["id"].stringValue,
            content: json["content"].stringValue,
            type: json["title"].stringValue
        )
    }
}

struct DiaryEntryDetails: Decodable {
    let id: String
    var items: [DiaryEntryItem]
    let createdAt: Date?

    static func decodeFromJson(_ json: JSON) -> DiaryEntryDetails {
        let items: [DiaryEntryItem]? = try? json["items"].parseIntoArray()
        return DiaryEntryDetails(
            id: json["id"].stringValue,
            items: items ?? [],
            createdAt: json["created_at"].date
        )
    }
}
