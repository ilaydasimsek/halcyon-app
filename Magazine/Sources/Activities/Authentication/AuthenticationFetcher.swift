import Foundation
import PromiseKit

protocol AuthenticationFetching {
    func login(email: String, password: String) -> Promise<Login>
    func signUp(email: String, password: String, passwordAgain: String) -> Promise<SignUp>
}

class AuthenticationFetcher: Fetcher, AuthenticationFetching {

    func login(email: String, password: String) -> Promise<Login> {
        return request(UserService.login(email: email, password: password))
    }

    func signUp(email: String, password: String, passwordAgain: String) -> Promise<SignUp> {
        return request(UserService.signup(email: email,
                                          password: password,
                                          passwordAgain: passwordAgain))
    }
}
