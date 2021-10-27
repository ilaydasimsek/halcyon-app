import Foundation
import PromiseKit

protocol AuthenticationFetching {
    func login(email: String, password: String) -> Promise<Login>
}

class AuthenticationFetcher: Fetcher, AuthenticationFetching {

    func login(email: String, password: String) -> Promise<Login> {
        return request(UserService.login(email: email, password: password))
    }
}
