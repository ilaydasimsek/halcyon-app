import XCTest
@testable import Halcyon

class EntryViewControllerTests: XCTestCase {
    let mockCoordinator = MockAuthenticationCoordinator()

    func test_navigationBarStatus_Hidden() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertEqual(controller.navigatioBarStatus, .hidden)
    }

    func test_viewLoadedSuccessfully() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertNotNil(controller.view)
        XCTAssertEqual(controller.rootView, controller.view)
    }

    func test_baseCoordinator_EqualToCoordinator() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        guard let baseCoordinator = controller.baseCoordinator as? MockAuthenticationCoordinator else {
            XCTFail("Base Coordinator must be the same as controllers own coordinator")
            return
        }

        XCTAssertEqual(baseCoordinator, mockCoordinator)
    }

    func test_hasCorrectView() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertEqual(type(of: controller.rootView).nibIdentifier, EntryView.nibIdentifier)
    }

    func test_loginButton_ActionCorrectness() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        controller.viewDidLoad()

        let expectedActionName = "onClickLoginButton"
        let targets = controller.rootView.loginButton.allTargets

        XCTAssertEqual(targets.count, 1)
        
        let target = targets.first!
        let actionName = controller.rootView.loginButton.actions(forTarget: target, forControlEvent: .touchUpInside)?.first

        XCTAssertNotNil(actionName)
        XCTAssertEqual(actionName, expectedActionName)
    }

    func test_registerButton_ActionCorrectness() {
        let controller = EntryViewController(coordinator: mockCoordinator)
        controller.viewDidLoad()

        let expectedActionName = "onClickRegisterButton"
        let targets = controller.rootView.registerButton.allTargets

        XCTAssertEqual(targets.count, 1)
        
        let target = targets.first!
        let actionName = controller.rootView.registerButton.actions(forTarget: target, forControlEvent: .touchUpInside)?.first

        XCTAssertNotNil(actionName)
        XCTAssertEqual(actionName, expectedActionName)
    }

}
