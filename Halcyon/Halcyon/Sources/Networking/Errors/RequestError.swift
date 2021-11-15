import Foundation
import FirebaseAuth

enum RequestError: Error {

    case networkError
    case unknownError
    case decodeError
    case authError(_ authError: AuthError)

    var message: String {
        switch self {
        case .networkError:
            return "No connection"
        case .decodeError:
            return "Something went wrong"
        case .unknownError:
            return "Something went wrong"
        case .authError(let error):
            return error.message
        }
    }

    static func from(_ error: Error) -> RequestError {
        if let errorCode = AuthErrorCode(rawValue: (error as NSError).code) {
            return .authError(AuthError.from(errorCode))
        }
    
        return .unknownError
    }
    
}
