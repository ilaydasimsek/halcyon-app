import Foundation
import PromiseKit
import FirebaseAuth

protocol Authenticating {
    var authenticated: Bool { get }
    func login(email: String, password: String) -> Promise<Authentication>
    func register(email: String, password: String) -> Promise<Authentication>
    
}

class FirebaseAuthenticator: Authenticating {
    let authStateChangeListener: AuthStateDidChangeListenerHandle
    var authenticated: Bool {
        return Auth.auth().currentUser != nil
    }

    init() {
        self.authStateChangeListener = Auth.auth().addStateDidChangeListener { auth, user in
            NotificationCenter.default.post(name: NotificationConstants.authStateChanged,
                                            object: nil,
                                            userInfo: [:])
        }
    }

    func login(email: String, password: String) -> Promise<Authentication> {
        return Promise { promiseSeal in
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                self?.handleAuthResult(authResult, error: error, promiseSeal: promiseSeal)
            }
        }
    }

    func register(email: String, password: String) -> Promise<Authentication> {
        return Promise { promiseSeal in
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                self?.handleAuthResult(authResult, error: error, promiseSeal: promiseSeal)
            }
        }
    }

    private func handleAuthResult(_ authResult: AuthDataResult?, error: Error?, promiseSeal: Resolver<Authentication>) {
        if let error = error {
            promiseSeal.reject(RequestError.from(error))
        } else if let authResult = authResult {
            let auth = Authentication.decodeFromFirebaseUser(authResult.user)
            promiseSeal.fulfill(auth)
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(authStateChangeListener)
    }
}
