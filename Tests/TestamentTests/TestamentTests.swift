import XCTest
@testable import Testament

class TestamentTests: XCTestCase {
    static var allTests = [
        ("testUnwrapping", testUnwrapping),
        ("testCasting", testCasting)
    ]

    // TODO: Tests may cover more use cases!

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
            let int: Int = try Casting(anyInt).make()
            XCTAssert(int == 1337)
        } catch { }
    }
}
