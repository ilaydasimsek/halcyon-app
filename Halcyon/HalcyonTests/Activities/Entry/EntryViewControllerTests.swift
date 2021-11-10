import XCTest
@testable import Halcyon

class EntryViewControllerTests: XCTestCase {

    func test_coordinatorInitialization_ViewLoadSuccess() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertNotNil(controller.view)
        XCTAssertEqual(controller.rootView, controller.view)
    }

    func test_baseCoordinator_EqualToCoordinator() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        guard let baseCoordinator = controller.baseCoordinator as? MockAuthenticationCoordinator else {
            XCTFail("Base Coordinator must be the same as controllers own coordinator")
            return
        }

        XCTAssertEqual(baseCoordinator, mockCoordinator)
    }

    func test_controllerView_Correctness() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertEqual(type(of: controller.rootView).nibIdentifier, EntryView.nibIdentifier)
    }

    func test_navigationBarStatus_Hidden() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        XCTAssertEqual(controller.navigatioBarStatus, .hidden)
    }

    func test_loginButton_ActionCorrectness() {
        let mockCoordinator = MockAuthenticationCoordinator()
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
        let mockCoordinator = MockAuthenticationCoordinator()
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

    func test_loginButtonTapped_StartLoginCalled() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        controller.viewDidLoad()

        guard let selector = getSelector(for: controller.rootView.loginButton) else {
            XCTFail("Login button selector should not be nil")
            return
        }

        controller.perform(selector)
        XCTAssertEqual(mockCoordinator.startRegisterCalledSucessfully, false)
        XCTAssertEqual(mockCoordinator.startLoginCalledSucessfully, true)
    }

    func test_registerButtonTapped_StartRegisterCalled() {
        let mockCoordinator = MockAuthenticationCoordinator()
        let controller = EntryViewController(coordinator: mockCoordinator)
        controller.viewDidLoad()

        guard let selector = getSelector(for: controller.rootView.registerButton) else {
            XCTFail("Register button selector should not be nil")
            return
        }

        controller.perform(selector)
        XCTAssertEqual(mockCoordinator.startRegisterCalledSucessfully, true)
        XCTAssertEqual(mockCoordinator.startLoginCalledSucessfully, false)
    }

    private func getSelector(for button: UIButton) -> Selector? {
        let targets = button.allTargets
        
        guard let target = targets.first,
              let actionName = button.actions(forTarget: target, forControlEvent: .touchUpInside)?.first
        else { return nil }

        return NSSelectorFromString(actionName)
    }
}
