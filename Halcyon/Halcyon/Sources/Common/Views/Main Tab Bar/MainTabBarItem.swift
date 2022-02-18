import UIKit
import SwiftyJSON
import Nuke

enum MainTabBarItemType: String {
    case profile
    case diaryEntries
}

struct MainTabBarItem: Decodable {

    let type: MainTabBarItemType?
    let title: String
    let iconUrl: URL?
    let tag: String
    
    static func decodeFromJson(_ json: JSON) throws -> MainTabBarItem {
        return MainTabBarItem(
            type: MainTabBarItemType(rawValue: json["type"].stringValue),
            title: json["label"].stringValue,
            iconUrl: json["icon"].url,
            tag: json["type"].stringValue)
    }
}
