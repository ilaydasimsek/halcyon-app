import Alamofire
import UIKit

typealias Headers = [String: String]
typealias RequestParameters = [String: String]

struct NetworkingConstants {
    static let baseUrl: URL = URL(string: "http://localhost:3000/")!
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

enum FirestoreDataType {
    case singleDocument
    case multipleDocuments
}

enum RequestType {
    case firebase(dataType: FirestoreDataType)
    case http
    case authentication
}


protocol Requestable {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: RequestParameters { get }
    var type: RequestType { get }
}
