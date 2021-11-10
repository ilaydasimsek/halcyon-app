@testable import Halcyon
import UIKit
import MapKit

class MockAuthenticationCoordinator: Coordinatable, AuthenticationCoordinating, Equatable {
    
    var navigationController: UINavigationController = NavigationController()

    var startLoginCalledSucessfully: Bool = false
    var startRegisterCalledSucessfully: Bool = false

    func start() {
        
    }

    func startLogin() {
        self.startLoginCalledSucessfully = true
    }
    
    func startRegister() {
        self.startRegisterCalledSucessfully = true
    }
    
    func onLoginCompleted(fromRegister: Bool) {
        
    }
    
    func onError(_ error: Error) {
        
    }

    static func == (lhs: MockAuthenticationCoordinator, rhs: MockAuthenticationCoordinator) -> Bool {
        return lhs === rhs
    }
}
