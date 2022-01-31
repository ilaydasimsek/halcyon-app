import Foundation

struct DiaryEntryItem: Decodable {
    let title: String
    let creationDate: Date?

    static func decode(_ data: Data) throws -> DiaryEntryItem {
        let json = try data.asJson()
        return DiaryEntryItem(
            title: json["title"].stringValue,
            creationDate: json["creationDate"].date
        )
    }
}


struct DiaryEntries: Decodable {
    let items: [DiaryEntryItem]

    static func decode(_ data: Data) throws -> DiaryEntries {
        let json = try data.asJson()
        let items: [DiaryEntryItem]? = try? json["items"].parseIntoArray()
        return DiaryEntries(
            items: items ?? []
        )
    }
}
