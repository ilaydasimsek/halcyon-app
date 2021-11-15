import Foundation
import PromiseKit
import FirebaseAuth

protocol Authenticating {
    func login(email: String, password: String) -> Promise<Authentication>
    func register(email: String, password: String) -> Promise<Authentication>
    
}

class AuthService: Authenticating {

    func login(email: String, password: String) -> Promise<Authentication> {
        return Promise { promiseSeal in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    promiseSeal.reject(RequestError.from(error))
                } else if let authResult = authResult {
                    let user = authResult.user
                    let auth = Authentication(userId: user.uid, email: user.email ?? "", accessToken: user.uid)
                    promiseSeal.fulfill(auth)
                }
            }
        }
    }

    func register(email: String, password: String) -> Promise<Authentication> {
        return Promise { promiseSeal in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promiseSeal.reject(RequestError.from(error))
                } else if let authResult = authResult {
                    let user = authResult.user
                    let auth = Authentication(userId: user.uid, email: user.email ?? "", accessToken: user.uid)
                    promiseSeal.fulfill(auth)
                }
            }
        }

    }
}
