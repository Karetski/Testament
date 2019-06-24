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
        ("testThrowingAny", testThrowingAny),
        ("testThrowingAnyThrows", testThrowingAnyThrows)
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

    func testThrowing() throws {
        try assertThrows(Stubs.throwAny(), with: Stubs.AnyError.self)
    }

    func testThrowingThrows() {
        do {
            try assertThrows(Stubs.throwAny(), with: Stubs.AnyError.self)
        } catch {
            XCTFail("There shouldn't be any errors")
        }

        do {
            try assertThrows(Stubs.returnValue(), with: Stubs.AnyError.self, message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unableToThrow(let expectedErrorType, let expressionResultType) {
            XCTAssertTrue(expectedErrorType == Stubs.AnyError.self)
            XCTAssertTrue(expressionResultType == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            try assertThrows(Stubs.throwAnyOther(), with: Stubs.AnyError.self, message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unexpectedError(let expectedErrorType, let expressionResultType) {
            XCTAssertTrue(expectedErrorType == Stubs.AnyError.self)
            XCTAssertTrue(expressionResultType == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}

