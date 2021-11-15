import FirebaseAuth

enum AuthError: Error {
    case wrongPassword
    case userNotFound
    case invalidEmail
    case sessionInvalid
    case accountExists
    case networkError
    case weakPassword
    case unverifiedEmail
    case unknown

    static func from(_ errorCode: AuthErrorCode) -> AuthError {
        switch errorCode {
        case .invalidEmail:
            return .invalidEmail
        case .wrongPassword:
            return .wrongPassword
        case .nullUser, .userNotFound:
            return .userNotFound
        case .accountExistsWithDifferentCredential, .emailAlreadyInUse:
            return .accountExists
        case .userTokenExpired, .invalidUserToken, .sessionExpired:
            return .sessionInvalid
        case .networkError:
            return .networkError
        case .weakPassword:
            return weakPassword
        case .invalidRecipientEmail, .missingEmail:
            return .invalidEmail
        case .unverifiedEmail:
            return unverifiedEmail
        default:
            return .unknown
        }
    }

    // TODO Add better error messages
    var message: String {
        switch self {
        case .wrongPassword:
            return "Wrong password"
        case .userNotFound:
            return "User not found"
        case .invalidEmail:
            return "Email is invalid"
        case .accountExists:
            return "Account already exists"
        case .networkError:
            return "Network error. Please check your connection"
        case .weakPassword:
            return "Password is weak"
        case .unverifiedEmail:
            return "Email is not verified"
        default:
            return "Something went wrong"
        }
    }
}
