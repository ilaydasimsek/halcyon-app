import Foundation

struct Login: Decodable {

    static func decode(_ data: Data) throws -> Login {
        let json = try data.asJson()
        return Login(
            
        )
    }
}
