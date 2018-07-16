import XCTest
@testable import Testament

class TestamentTests: XCTestCase {
    static var allTests = [
        ("testUnwrapping", testUnwrapping),
        ("testUnwrappingCustomAssertion", testUnwrappingCustomAssertion),
        ("testCasting", testCasting),
        ("testCastingCustomAssertion", testCastingCustomAssertion)
    ]

    func testUnwrapping() throws {
        let possibleString: String? = "SomeString"
        let string = try Unwrapping(possibleString).make()
        XCTAssert(string == "SomeString")
    }

    func testUnwrappingCustomAssertion() {
        do {
            let possibleString: String? = "SomeString"
            let string = try Unwrapping(possibleString, isCustomAssertionApplied: true).make()
            XCTAssert(string == "SomeString")
        } catch UnwrappingError.unableToUnwrap {
            XCTFail("Error must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            let possibleString: String? = nil
            let _ = try Unwrapping(possibleString, isCustomAssertionApplied: true).make()
            XCTFail("Error must be already thrown")
        } catch UnwrappingError.unableToUnwrap(let type) {
            XCTAssert(type == String.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testCasting() throws {
        let anyInt: Any = 1337
        let int: Int = try Casting(anyInt).make()
        XCTAssert(int == 1337)
    }

    func testCastingCustomAssertion() {
        do {
            let any: Any = 1337
            let int: Int = try Casting(any, isCustomAssertionApplied: true).make()
            XCTAssert(int == 1337)
        } catch CastingError.unableToCast {
            XCTFail("Error must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            let any: Any = "1337"
            _ = try Casting<Int>(any, isCustomAssertionApplied: true).make()
            XCTFail("Error must be already thrown")
        } catch CastingError.unableToCast(let instance, let type) {
            XCTAssert(instance as? String == "1337")
            XCTAssert(type == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
