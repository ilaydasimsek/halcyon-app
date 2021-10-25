import Foundation

struct SignUp: Decodable {

    static func decode(_ data: Data) throws -> SignUp {
        let json = try data.asJson()
        return SignUp(
            
        )
    }
}
