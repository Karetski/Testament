import XCTest

@testable import Testament

class TestamentTests: XCTestCase {
    static var allTests = [
        ("testUnwrapping", testUnwrapping),
        ("testUnwrappingThrows", testUnwrappingThrows),
        ("testCasting", testCasting),
        ("testCastingThrows", testCastingThrows)
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

    func testCasting() throws {
        let anyInt: Any = 1337
        let int = try assertCasts(anyInt, to: Int.self)
        XCTAssert(int == 1337)
    }

    func testCastingThrows() {
        do {
            let anyInt: Any = 1337
            let int = try assertCasts(anyInt, to: Int.self, message: nil)
            XCTAssert(int == 1337)
        } catch CastingError.unableToCast {
            XCTFail("Error must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            let any: Any = "1337"
            try assertCasts(any, to: Int.self, message: nil)
            XCTFail("Error must be already thrown")
        } catch CastingError.unableToCast(let instance, let type) {
            XCTAssert(instance as? String == "1337")
            XCTAssert(type == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
