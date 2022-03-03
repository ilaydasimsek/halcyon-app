import SwiftyJSON

extension JSON {

    /**
        Given a list of json items, decodes them into a list of models with given type.
 
        - Warning:
        Json must be of type array, otherwise this function will return an empty list and log an error.
     */
    func parseIntoArray<T: Decodable>() throws -> [T] {
        switch self.type {
        case .array:
            return try self.arrayValue.map { json in
                guard let item = try? T.decodeFromJson(json) else {
                    throw RequestError.decodeError
                }
                return item
            }
        case .dictionary:
            let array: [JSON] = self.dictionaryValue.map({$1})
            return try array.map { json in
                guard let item = try? T.decodeFromJson(json) else {
                    throw RequestError.decodeError
                }
                return item
            }
        default:
            throw RequestError.decodeError
        }
    }
}
