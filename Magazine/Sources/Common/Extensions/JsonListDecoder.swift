import SwiftyJSON

class JsonListDecoder<Item: Decodable> {

    func decode(_ json: JSON, maxCount: Int = 0) throws -> [Item] {
        if json.type != .array {
            if let data = try? json.rawData() {
                return [try Item.decode(data)]
            }
            return []
        }

        var arrayList = json.arrayValue
        if maxCount > 0 {
            arrayList = Array(arrayList.prefix(min(maxCount, arrayList.count)))
        }
        return try arrayList.map { json in

            if let itemData = try? json.rawData() {
                return try Item.decode(itemData)
            }
            throw RequestError.networkError

        }
    }
}
