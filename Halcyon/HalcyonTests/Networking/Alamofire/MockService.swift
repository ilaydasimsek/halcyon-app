import Foundation
@testable import Halcyon

enum MockError: Error {
    case mock
}

enum MockService: Requestable {
    case getRequest
    case postRequest
    case putRequest
    case patchRequest
    case deleteRequest
    
    var baseUrl: URL {
        return URL(string:"https://mock/")!
    }
    
    var path: String {
        switch self {
        case .getRequest:
            return "/get"
        case .postRequest:
            return "/post"
        case .putRequest:
            return "/put"
        case .patchRequest:
            return "/patch"
        case .deleteRequest:
            return "/delete"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getRequest:
            return .get
        case .postRequest:
            return .post
        case .putRequest:
            return .put
        case .patchRequest:
            return .patch
        case .deleteRequest:
            return .delete
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getRequest, .deleteRequest:
            return [:]
        default:
            return ["param1": "value", "param2": "value"]
        }
    }
}
