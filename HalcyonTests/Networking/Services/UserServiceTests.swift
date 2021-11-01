import XCTest
@testable import Halcyon

class UserServiceTests: XCTestCase {
    // TODO add cases to test model creation and sending requests
    let networking: Networking = AlamofireNetwork()

    func test_ProfileRequest_Correctness() {
        let mockUserId = "123456"
        let request = UserService.profile(userId: mockUserId)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.parameters, RequestParameters())
        XCTAssertEqual(request.path, "user/\(mockUserId)")
    }

    func test_LoginRequest_Correctness() {
        let mockEmail = "test_user@email.com"
        let mockPassword = "password"
        let request = UserService.login(email: mockEmail, password: mockPassword)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.parameters, ["email": mockEmail, "password": mockPassword])
        XCTAssertEqual(request.path, "login")
    }

    func test_RegisterRequest_Correctness() {
        let mockEmail = "test_user@email.com"
        let mockPassword = "password"
        let request = UserService.register(email: mockEmail, password: mockPassword)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.parameters, ["email": mockEmail, "password": mockPassword])
        XCTAssertEqual(request.path, "register")
    }

}
