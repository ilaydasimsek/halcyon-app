import Foundation

struct MainScreen: Decodable {
    let name: String

    static func decode(_ data: Data) throws -> MainScreen {
        let json = try data.asJson()
        return MainScreen(
            name: json["name"].stringValue
        )
    }
}
