import Foundation
import PromiseKit
import FirebaseAuth
import OSLog

protocol Authenticating {
    var authenticated: Bool { get }
    var userId: String? { get }
    func login(email: String, password: String) -> Promise<Authentication>
    func register(email: String, password: String) -> Promise<Authentication>
    func logout() -> Bool
}

class FirebaseAuthenticator: Authenticating {
    let authStateChangeListener: AuthStateDidChangeListenerHandle
    let firebaseAuth = Auth.auth()
    var userId: String? {
        return firebaseAuth.currentUser?.uid
    }
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
            firebaseAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
                self?.handleAuthResult(authResult, error: error, promiseSeal: promiseSeal)
            }
        }
    }

    func register(email: String, password: String) -> Promise<Authentication> {
        return Promise { promiseSeal in
            firebaseAuth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
                self?.handleAuthResult(authResult, error: error, promiseSeal: promiseSeal)
            }
        }
    }

    @discardableResult
    func logout() -> Bool {
        do {
            try firebaseAuth.signOut()
            return true
        } catch let signOutError as NSError {
            Logger().log(level: .error, "Error signing out: \(signOutError)")
            return false
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
