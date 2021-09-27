import UIKit
import SwiftyJSON
import Nuke

struct MainTabBarItem: Decodable {

    let title: String
    let iconUrl: URL?
    let tag: Int
    
    static func decode(_ data: Data) throws -> MainTabBarItem {
        let json = try data.asJson()
        return MainTabBarItem(
            title: json["label"].stringValue,
            iconUrl: json["icon"].url,
            tag: json["screen"].intValue)
    }
}
