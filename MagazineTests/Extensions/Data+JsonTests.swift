import XCTest
import SwiftyJSON
@testable import Magazine

class DataJsonTests: XCTestCase {

    func testParseJson_ValidData() {
        do {
            let _ = try validJsonData.asJson()
        } catch let error {
            XCTFail("Decode shouldn't throw the exception \(error)")
        }
    }

    func testParseJson_InvalidData() {
        do {
            let _ = try invalidJsonData.asJson()
            XCTFail("Decode should throw an exception when json is invalid")
        } catch let error {
            XCTAssertEqual(error as? RequestError, RequestError.decodeError)
        }
    }
}

extension DataJsonTests {

    var validJsonData: Data {
        return Data("{\"test\":\"test\", \"test1\":1}".utf8)
    }
    var invalidJsonData: Data {
        return Data("test".utf8)
    }
}
