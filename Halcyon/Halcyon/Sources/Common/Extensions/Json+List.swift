import SwiftyJSON

extension JSON {

    /**
        Given a list of json items, decodes them into a list of models with given type.
 
        - Warning:
        Json must be of type array, otherwise this function will return an empty list and log an error.
     */
    func parseIntoArray<T: Decodable>() throws -> [T] {
        if self.type != .array {
            throw RequestError.decodeError
        }

        return try self.arrayValue.map { json in
            guard let item = try? T.decode(json.rawData()) else {
                throw RequestError.decodeError
            }
            return item
        }
    }
}
