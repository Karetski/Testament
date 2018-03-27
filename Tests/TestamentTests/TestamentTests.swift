import XCTest
@testable import Testament

class TestamentTests: XCTestCase {
    static var allTests = [
        ("testUnwrapping", testUnwrapping),
        ("testCasting", testCasting)
    ]

    func testUnwrapping() {
        do {
            let optionalString: String? = "String"
            let string = try Unwrapping(optionalString).make()
            XCTAssert(string == "String")
        } catch { }
    }

    func testCasting() {
        do {
            let anyInt: Any = 1337
            let int = try Casting(anyInt, to: Int.self).make()
            XCTAssert(int == 1337)
        } catch { }
    }
}
