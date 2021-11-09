import XCTest
import SwiftyJSON
@testable import Halcyon

struct MockItemModel: Decodable, Equatable {
    let id: Int
    let type: String

    static func decode(_ data: Data) throws -> MockItemModel {
        let json = try data.asJson()
        return MockItemModel(
            id: json["id"].intValue,
            type: json["type"].stringValue
        )
    }
}

class JsonListTests: XCTestCase {

    func testParseIntoArray_ValidJson() {
        do {
            let decodedArray: [MockItemModel] = try mockJson["mockArray"].parseIntoArray()
            XCTAssertEqual(decodedArray, expectedMockList)
        } catch let error {
            XCTFail("Decode shouldn't throw the exception \(error)")
        }
    }

    func testParseIntoArray_InvalidJson() {
        do {
            let _: [MockItemModel] = try incorrectMockJson.parseIntoArray()
        } catch let error {
            XCTAssertEqual(error as? RequestError, RequestError.decodeError)
        }
    }
}

// MARK: - Mock Data
extension JsonListTests {

    private var mockJson: JSON {
        return JSON([
            "mockArray": [
                ["type": "mock1", "id": 1],
                ["type": "mock2", "id": 2]]
            ]
        )
    }
    
    private var incorrectMockJson: JSON {
        return JSON([
            "mockData": "data"
        ])
    }

    private var expectedMockList: [MockItemModel] {
        return [
            MockItemModel(id: 1, type: "mock1"),
            MockItemModel(id: 2, type: "mock2"),
        ]
    }
}
