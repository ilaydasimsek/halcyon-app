import Foundation
import PromiseKit

protocol AuthenticationFetching {
    func login(username: String, password: String) -> Promise<Login>
}

class AuthenticationFetcher: Fetcher, AuthenticationFetching {

    func login(username: String, password: String) -> Promise<Login> {
        return request(UserService.login(username: username, password: password))
    }
}
