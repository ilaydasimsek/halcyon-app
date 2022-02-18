import Foundation

enum FirestoreNetworkingService: Requestable {
    case diaryEntries
    case entry(id: String)

    var baseUrl: URL {
        return ""
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
        return .get
    }

    var parameters: RequestParameters {
        return [:]
    }

    var type: RequestType {
        switch self {
        case .diaryEntries:
            return .firebase(dataType: .multipleDocuments)
        }
    }
}
