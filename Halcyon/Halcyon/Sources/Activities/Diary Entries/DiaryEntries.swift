import Foundation

struct DiaryEntries: Decodable {

    static func decode(_ data: Data) throws -> DiaryEntries {
        let json = try data.asJson()
        return DiaryEntries(
            
        )
    }
}
