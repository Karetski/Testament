import XCTest
@testable import Testament

class TestamentTests: XCTestCase {
    func testExample() {
        do {
            let asd: String? = ""
            let qwe = try Unwrapping(asd).make()
        } catch { }

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
