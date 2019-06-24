import XCTest

@testable import Testament

class CastingTests: XCTestCase {
    static var allTests = [
        ("testCasting", testCasting),
        ("testCastingThrows", testCastingThrows)
    ]

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
