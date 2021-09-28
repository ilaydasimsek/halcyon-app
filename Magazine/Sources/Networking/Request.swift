import Alamofire
import UIKit

typealias Headers = [String: String]
typealias RequestParameters = [String: Any]

struct NetworkingConstants {
    static let baseUrl: URL = URL(string: "")!
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    var alamofireEquivalent: Alamofire.HTTPMethod {
        Alamofire.HTTPMethod.init(rawValue: self.rawValue)
    }

    var encoding: Alamofire.ParameterEncoding {
        switch self {
        case .post, .put, .patch:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}


protocol Requestable {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: RequestParameters { get }
}
