import XCTest
@testable import Testament

class TestamentTests: XCTestCase {
    func testExample() {
        do {
            let optionalString: String? = ""
            let _ = try Unwrapping(optionalString).make()

            let anyInt: Any = 1337
            let _ = try Casting(anyInt, to: Int.self).make()
        } catch { }

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
