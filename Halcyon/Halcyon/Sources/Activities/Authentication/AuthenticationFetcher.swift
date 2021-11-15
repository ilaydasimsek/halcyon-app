import Foundation
import PromiseKit

protocol AuthenticationFetching {
    func login(email: String, password: String) -> Promise<Authentication>
    func register(email: String, password: String) -> Promise<Authentication>
}

class AuthenticationFetcher: Fetcher, AuthenticationFetching {

    func login(email: String, password: String) -> Promise<Authentication> {
        return auth.login(email: email, password: password)
    }

    func register(email: String, password: String) -> Promise<Authentication> {
        return auth.register(email: email, password: password)
    }
}
