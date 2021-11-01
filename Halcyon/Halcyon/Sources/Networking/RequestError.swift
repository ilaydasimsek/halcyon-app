enum RequestError: Error {

    case networkError
    case unknownError
    case decodeError

    var message: String {
        switch self {
        case .networkError:
            return "No connection"
        case .decodeError:
            return "Something went wrong"
        case .unknownError:
            return "Something went wrong"
        }
    }
}
