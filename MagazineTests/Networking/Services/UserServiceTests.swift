import XCTest
@testable import Magazine

class UserServiceTests: XCTestCase {
    // TODO add cases to test model creation and sending requests
    let networking: Networking = AlamofireNetwork()

    func testProfileRequestCorrectness() {
        let mockUserId = "123456"
        let request = UserService.profile(userId: mockUserId)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.parameters, RequestParameters())
        XCTAssertEqual(request.path, "user/\(mockUserId)")
    }

    func testLoginRequestCorrectness() {
        let mockUserName = "test_user"
        let mockPassword = "password"
        let request = UserService.login(userName: mockUserName, password: mockPassword)
        
        XCTAssertEqual(request.baseUrl, NetworkingConstants.baseUrl)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.parameters, ["user_name":mockUserName, "password": mockPassword])
        XCTAssertEqual(request.path, "login")
    }

}
