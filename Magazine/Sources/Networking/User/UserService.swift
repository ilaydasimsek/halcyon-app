import Foundation

enum UserService: Requestable {
    case profile(userId: String)
    case login(email: String, password: String)

    var baseUrl: URL {
        return NetworkingConstants.baseUrl
    }

    var path: String {
        switch self {
        case .profile(let userId):
            return "user/\(userId)"
        case .login:
            return "login"
        }
    }

    var method: HttpMethod {
        switch self {
        case .profile:
            return .get
        case .login:
            return .post
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .profile(_):
            return [:]
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }
}
