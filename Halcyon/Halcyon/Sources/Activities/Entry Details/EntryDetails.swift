import Foundation
import SwiftyJSON

struct DiaryEntryItem: Decodable {
    let id: String
    let title: String
    let type: String

    static func decodeFromJson(_ json: JSON) throws -> DiaryEntryItem {
        return DiaryEntryItem(
            id: json["type"].stringValue,
            title: json["id"].stringValue,
            type: json["title"].stringValue
        )
    }
}

struct DiaryEntryDetails: Decodable {
    let id: String
    let items: [DiaryEntryItem]
    let creationDate: Date?

    static func decodeFromJson(_ json: JSON) -> DiaryEntryDetails {
        let items: [DiaryEntryItem]? = try? json["items"].parseIntoArray()
        return DiaryEntryDetails(
            id: json["type"].stringValue,
            items: items ?? [],
            creationDate: json["creationDate"].date
        )
    }
}
