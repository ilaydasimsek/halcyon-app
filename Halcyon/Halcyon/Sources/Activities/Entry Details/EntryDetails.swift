import Foundation

struct DiaryEntryItem: Decodable {
    let id: String
    let title: String
    let type: String

    static func decode(_ data: Data) throws -> DiaryEntryItem {
        let json = try data.asJson()
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

    static func decode(_ data: Data) throws -> DiaryEntryDetails {
        let json = try data.asJson()
        let items: [DiaryEntryItem]? = try? json["items"].parseIntoArray()
        return DiaryEntryDetails(
            id: json["type"].stringValue,
            items: items ?? [],
            creationDate: json["creationDate"].date
        )
    }
}
