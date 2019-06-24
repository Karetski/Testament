import XCTest

@testable import Testament

private enum Stubs {
    struct AnyError: Swift.Error { }
    struct AnyOtherError: Swift.Error { }

    static func returnValue() throws -> Int {
        return 0
    }

    static func throwAny() throws -> Int {
        throw AnyError()
    }

    static func throwAnyOther() throws -> Int {
        throw AnyOtherError()
    }
}

class ThrowingTests: XCTestCase {
    static var allTests = [
        ("testThrowingAny", testThrowingAny)
    ]

    func testThrowingAny() throws {
        let error = try assertThrowsAny(try Stubs.throwAny())
        XCTAssertTrue(error is Stubs.AnyError)
    }

    func testThrowingAnyThrows() {
        do {
            let error = try assertThrowsAny(try Stubs.throwAny())
            XCTAssertTrue(error is Stubs.AnyError)
        } catch ThrowingError.unableToThrowAny(let type) {
            XCTFail("Error of \(type) must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            try assertThrowsAny(try Stubs.returnValue(), message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unableToThrowAny(let type) {
            XCTAssertTrue(type == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}

