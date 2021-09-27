import Foundation

enum MainScreenService: Requestable {
    case screen(info: ScreenInformation)

    var baseUrl: URL {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case .screen(let info):
            return "screen/\(info.id)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .screen(_):
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .screen(let info):
            return parameters(from: info.action)
        }
    }

    private func parameters(from action: ScreenAction) -> RequestParameters {
        switch action {
        case .showScreen(let detailId):
            return ["detail_id": detailId]
        default:
            return [:]
        }
    }
}
