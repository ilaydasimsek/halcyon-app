import Foundation

enum FirestoreNetworkingService: Requestable {
    case diaryEntries
    case entry(id: String)

    var baseUrl: URL {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case .diaryEntries:
            return "diary_entries"
        case .entry:
            return "entry_details"
        }
    }

    var method: HttpMethod {
        switch self {
        case .diaryEntries:
            return .get
        case .entry:
            return .get
        }
    }

    var parameters: RequestParameters {
        switch self {
        case .entry(let id):
            return ["id": id]
        default:
            return [:]
        }
    }

    var type: RequestType {
        switch self {
        case .diaryEntries:
            return .firebase(dataType: .multipleDocuments)
        case .entry:
            return .firebase(dataType: .singleDocument)
        }
    }
}
