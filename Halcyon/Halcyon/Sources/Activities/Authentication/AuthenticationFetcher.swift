import Foundation
import PromiseKit

protocol AuthenticationFetching {
    func login(email: String, password: String) -> Promise<Authentication>
    func register(email: String, password: String) -> Promise<Authentication>
}

class AuthenticationFetcher: Fetcher, AuthenticationFetching {

    func login(email: String, password: String) -> Promise<Authentication> {
        return self.networking.decodedRequest(UserService.login(email: email,
                                                                password: password))
    }

    func register(email: String, password: String) -> Promise<Authentication> {
        return self.networking.decodedRequest(UserService.register(email: email,
                                                                   password: password))
    }
}
