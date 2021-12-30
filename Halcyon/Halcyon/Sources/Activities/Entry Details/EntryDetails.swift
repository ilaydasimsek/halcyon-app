import Foundation

struct EntryDetails: Decodable {

    static func decode(_ data: Data) throws -> EntryDetails {
        let json = try data.asJson()
        return EntryDetails(
            
        )
    }
}
