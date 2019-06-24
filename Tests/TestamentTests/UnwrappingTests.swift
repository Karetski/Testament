import XCTest

@testable import Testament

class UnwrappingTests: XCTestCase {
    static var allTests = [
        ("testUnwrapping", testUnwrapping),
        ("testUnwrappingThrows", testUnwrappingThrows)
    ]

    func testUnwrapping() throws {
        let possibleString: String? = "SomeString"
        let string = try assertUnwraps(possibleString)
        XCTAssert(string == "SomeString")
    }

    func testUnwrappingThrows() {
        do {
            let possibleString: String? = "SomeString"
            let string = try assertUnwraps(possibleString, message: nil)
            XCTAssert(string == "SomeString")
        } catch UnwrappingError.unableToUnwrap {
            XCTFail("Error must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            let possibleString: String? = nil
            try assertUnwraps(possibleString, message: nil)
            XCTFail("Error must be already thrown")
        } catch UnwrappingError.unableToUnwrap(let type) {
            XCTAssert(type == String.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
