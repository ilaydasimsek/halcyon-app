import XCTest
@testable import Magazine

class UserServiceTests: XCTestCase {
    // TODO add cases to test model creation and sending requests
    let networking: Networking = AlamofireNetwork()

    func testProfileRequest_Correctness() {
        let mockUserId = "123456"
        let request = UserService.profile(userId: mockUserId)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.parameters, RequestParameters())
        XCTAssertEqual(request.path, "user/\(mockUserId)")
    }

    func testLoginRequest_Correctness() {
        let mockEmail = "test_user@email.com"
        let mockPassword = "password"
        let request = UserService.login(email: mockEmail, password: mockPassword)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.parameters, ["email": mockEmail, "password": mockPassword])
        XCTAssertEqual(request.path, "login")
    }

    func testRegisterRequest_Correctness() {
        let mockEmail = "test_user@email.com"
        let mockPassword = "password"
        let mockPasswordAgain = "passwordAgain"
        let request = UserService.register(email: mockEmail, password: mockPassword, passwordAgain: mockPasswordAgain)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.parameters, ["email": mockEmail, "password": mockPassword, "password_again": mockPasswordAgain])
        XCTAssertEqual(request.path, "register")
    }

}
