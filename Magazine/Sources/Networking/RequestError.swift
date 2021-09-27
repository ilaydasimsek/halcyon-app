enum RequestError: Error {

    case networkError
    case unknownError

    var message: String {
        switch self {
        case .networkError:
            return "No connection"
        case .unknownError:
            return "Something went wrong"
        }
    }
}
